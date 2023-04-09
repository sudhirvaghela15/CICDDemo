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
		return .success(root)
	}
	
}

// case base = "https://api.artic.edu/api/v1"
// case artworks = "/artworks"
// case imageSuffix = "/full/843,/0/default.jpg"

public enum Service {
	case getArtwork(QueryParams: Encodable?)
}


extension Service: TargetType {
	
	private var baseStr: String {
		get {
			return WebServiceHelper.baseURL+WebServiceHelper.baseVersion + "/"
		}
	}
	
	public var baseURL: URL {
		return URL(string: baseStr)!
	}
	
	public var path: String {
		switch self {
		case .getArtwork(_):
			return "artworks"
		}
	}
	
	public var method: HTTPMethod {
		switch self {
			
		default:
			return .get
		}
	}
	
	public var sampleData: Data {
		return Data()
	}
	
	public var headers: [String : String] {
		var params = Dictionary<String, String>()
		params["x-dw-client-id"] = ""
		params["Content-Type"] = "application/json"
		
		
		switch self {
		default:
			break
//			if let value = AuthHelper.bearerToken {
//				params["Authorization"] = value
//			}
		}
		return params
	}
	
	public var task: RequestTask {
		switch self {
		case .getArtwork(QueryParams: let QueryParams):
			if let params = QueryParams {
				return .requestParameters(params)
			}
			return .requestPlain
		}
	}
}

struct EmptyModel: Encodable {
	
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
	
	var task: RequestTask { get }
}

// MARK: - Validation Type
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


// MARK: - WebService Helper
public class WebServiceHelper {
	
	public enum ApiVersion: String {
		case v1
	}
	
	static var baseURL: String {
		get {
		return	"https://api.artic.edu/api/"
		}
	}
	
	static var baseVersion: String {
		get {
			return	ApiVersion.v1.rawValue
		}
	}
	
}

/// Represents an HTTP task.
public enum RequestTask {
	/// A request with no additional data.
	case requestPlain
	/// A requests body set with encoded parameters.
	case requestParameters(_ parameters: Encodable)
}
