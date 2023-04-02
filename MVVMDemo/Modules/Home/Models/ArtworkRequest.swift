//
//  ArtworkRequest.swift
//  MVVMDemo
//
//  Created by sudhir on 23/06/22.
//

import Foundation

struct ArtworkRequest: Encodable {
    var page: Int
    var limit: Int
}

extension ArtworkRequest {
	static func build(page: Int = 0, limit: Int = 10) -> ArtworkRequest {
		return .init(page: page, limit: limit)
	}
}
