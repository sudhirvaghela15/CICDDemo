//
//  URLSessionHTTPClient.swift
//  MVVMDemo
//
//  Created by Sudhir Vaghela on 31/03/23.
//

import Foundation

public final class URLSessionHTTPClient: HTTPClient {
	private let session: URLSession
	
	public typealias Result = HTTPClient.Result
	
	private struct UnexpectedValuesRepresentation: Error {}
	
	private struct URLSessionTaskWrapper: HTTPClientTask {
		let wrapped: URLSessionTask
		
		func cancel() {
			wrapped.cancel()
		}
	}
	
	public init(session: URLSession) {
		self.session = session
	}
}

// MARK: -  Helper Method's
extension URLSessionHTTPClient {
	@discardableResult
	public func get(from url: URL, completion: @escaping (Result) -> Void) -> HTTPClientTask {
		return createDataTask(from: URLRequest(url: url), completion: completion)
	}
	
	@discardableResult
	public func post(to url: URL, body: Data, completion: @escaping (Result) -> Void) -> HTTPClientTask {
		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		request.httpBody = body
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		return createDataTask(from: request, completion: completion)
	}
}

// MARK: - Private Method's
extension URLSessionHTTPClient {
	private func createDataTask(from urlRequest: URLRequest, completion: @escaping (Result) -> Void) -> HTTPClientTask {
		let task = session.dataTask(with: urlRequest) { [weak self] data, response, error in
			guard let self = self else { return }
			completion(self.createResult(fromData: data, response: response, error: error))
		}
		task.resume()
		return URLSessionTaskWrapper(wrapped: task)
	}
	
	private func createResult(fromData data: Data?, response: URLResponse?, error: Error?) -> HTTPClient.Result {
		Result {
			switch (data, response, error) {
			case let (_, _, .some(error)):
				throw error
				
			case let (.some(data), .some(response as HTTPURLResponse), .none):
				return (data, response)
				
			default:
				throw UnexpectedValuesRepresentation()
			}
		}
	}
}
