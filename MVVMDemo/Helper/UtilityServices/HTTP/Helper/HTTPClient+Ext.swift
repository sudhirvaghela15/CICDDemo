//
//  HTTPClient+Ext.swift
//  MVVMDemo
//
//  Created by sudhir on 02/04/23.
//

import Foundation

extension HTTPURLResponse {
	private static var OK_200: Int { return 200 }

	var isOK: Bool {
		return statusCode == HTTPURLResponse.OK_200
	}
}


public enum HTTPMethod: String, Equatable, Hashable {
	case connect = "CONNECT"
	case delete = "DELETE"
	case get = "GET"
	case head = "HEAD"
	case options = "OPTIONS"
	case patch = "PATCH"
	case post = "POST"
	case put = "PUT"
	case query = "QUERY"
	case trace = "TRACE"
}

