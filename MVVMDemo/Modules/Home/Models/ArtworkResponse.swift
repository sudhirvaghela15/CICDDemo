//
//  HomeMode.swift
//  MVVMDemo
//
//  Created by sudhir on 22/06/22.
//

import SwiftyUserDefaults

struct ArtworkResponse: Codable, DefaultsSerializable {
    var pagination: Pagination?
    var data: [ArtworkDetailModel]?
    var config: Config?
}

struct Config : Codable {
    var imageURL: String?
    var websiteURL: String?

    enum CodingKeys: String, CodingKey {
        case imageURL = "iiif_url"
        case websiteURL = "website_url"
    }
}

struct ArtworkDetailModel: Codable {
    let title: String?
    let artistTitle: String?
    let artistDisplay: String
    let placeOfOrigin: String?
    let artworkTypeTitle: String?
    let departmentTitle :String?
    let imageID: String?
    let date:String
    
    
    enum CodingKeys: String, CodingKey {
        case title
        case placeOfOrigin = "place_of_origin"
        case artistTitle = "artist_title"
        case artistDisplay = "artist_display"
        case departmentTitle = "department_title"
        case artworkTypeTitle = "artwork_type_title"
        case imageID = "image_id"
        case date = "date_display"
    }
}

// MARK: - Pagination
struct Pagination: Codable {
    var total, limit, offset, totalPages: Int?
    var currentPage: Int?
    var nextURL: String?

    enum CodingKeys: String, CodingKey {
        case total, limit, offset
        case totalPages = "total_pages"
        case currentPage = "current_page"
        case nextURL = "next_url"
    }
}
