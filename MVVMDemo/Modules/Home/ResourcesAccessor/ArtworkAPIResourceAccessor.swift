//
//  ArtworkAPIRepository.swift
//  MVVMDemo
//
//  Created by sudhir on 23/06/22.
//

import Foundation

final class ArtworkLoader {
	
	public typealias Result = Swift.Result<[ArtworkDetailModel], Error>
	
	private let client: HTTPClient
	private let url: URL
	
	public enum Error: Swift.Error {
		case connectivity
		case invalidData
	}
	
	public init(url: URL, client: HTTPClient) {
		self.url = url
		self.client = client
	}
	
	public func load(completion: @escaping (Result) -> Void) {
		client.get(from: url) { [weak self] result in
			guard self != nil else { return } /// added berriear for check if self is nil api result do not deliver
			
			switch result {
			case let .success((data, httpResponse )):
				completion(FeedItemMapper.map(data, httpResponse: httpResponse))
			case .failure:
				completion(.failure(Error.connectivity))
			}
		}
	}
}
