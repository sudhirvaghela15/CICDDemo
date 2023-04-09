//
//  ArtworkAPIRepository.swift
//  MVVMDemo
//
//  Created by sudhir on 23/06/22.
//

import Foundation

final class ArtworkLoader {
	
	public typealias Result = Swift.Result<ArtworkResponse, Error>
	
	private let client: HTTPClient
	var service: Service
	
	public enum Error: Swift.Error {
		case connectivity
		case invalidData
	}
	
	public init(service: Service, client: HTTPClient) {
		self.service = service
		self.client = client
	}
	
	
	public func load(completion: @escaping (Result) -> Void) {
		client.get(from:  createRequestURL(service: service)) { [weak self] result in
			guard self != nil else { return } /// added berriear for check if self is nil api result do not deliver

			switch result {
			case let .success((data, httpResponse )):
				completion(FeedItemMapper.map(data, httpResponse: httpResponse))
			case .failure:
				completion(.failure(Error.connectivity))
			}
		}
	}
	
	
	
	func createRequestURL(service: Service) -> URL {
		let url = URL(string: "\(service.baseURL.absoluteURL)\(service.path)")!
		switch service.task {
		case .requestPlain:
			return url
		case let .requestParameters(params):
				var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
				let params = params.convertToURLQueryItems()
				components?.queryItems = params
				return components?.url ?? url
		}
		
	}
}
