//
//  ArtworkRequest.swift
//  MVVMDemo
//
//  Created by sudhir on 23/06/22.
//

import Foundation

struct ArtworkRequest : Encodable {
    var page : Int
    var limit : Int = 10
}
