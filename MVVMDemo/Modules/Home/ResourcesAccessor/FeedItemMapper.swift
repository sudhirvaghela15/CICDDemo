//
//  FeedItemMapper.swift
//  MVVMDemo
//
//  Created by sudhir on 02/04/23.
//

import Foundation

final class FeedItemMapper {
	
	static func map(_ data: Data, httpResponse: HTTPURLResponse) -> ArtworkLoader.Result {
		guard httpResponse.isOK,
			  let root = try? JSONDecoder().decode(ArtworkResponse.self, from: data) else {
			return .failure(ArtworkLoader.Error.invalidData)
		}
		return .success(root.data ?? [])
	}
	
}

//case base = "https://api.artic.edu/api/v1"
//case artworks = "/artworks"
//case imageSuffix = "/full/843,/0/default.jpg"

public enum Service {
	case getArtwork(QueryParams: Encodable?, BodyParams: Encodable?)
}


extension Service {
	
}




public protocol TargetType {
	/// the target's base url
	var baseURL: URL { get }
	
	/// the path to be appended to `baseURL` to from the full `URL`.
	var path: String { get }
	
	/// the HTTP method used in the request.
	var method: HTTPMethod { get }
	
	/// provides stub data for use in testing
	var sampleData: Data { get }
	
	/// the headers to be used in the request.
	var headers: [String: String] { get }
}








public enum ValidationType {
	/// No validataion
	case none
	
	/// validation success codes only (2xx)
	case successCodes
	
	/// validation success codeas and redirection codes e.g 2xx and 3xx
	case successAndRedirectiondCodes

	var statusCodes: [Int] {
		switch self {
			case .none:
				return []
			case .successCodes:
				return Array(200..<300)
			case .successAndRedirectiondCodes:
				return Array(200...400)
		}
	}
}
