//
//  HTTPClinet.swift
//  MVVMDemo
//
//  Created by Sudhir Vaghela on 31/03/23.
//

import Foundation

public protocol HTTPClientTask {
	func cancel()
}

public protocol HTTPClient {
	typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>
	
	@discardableResult
	func get(from url: URL, completion: @escaping (Result) -> Void) -> HTTPClientTask
	
	@discardableResult
	func post(to url: URL, body: Data, completion: @escaping (Result) -> Void) -> HTTPClientTask
}
