//
//  HomeFeedVC.swift
//  MVVMDemo
//
//  Created by sudhir on 22/06/22.
//
import Foundation

protocol HomeFeedPresentable {
    var title : String { get set}
    var artist_display: String { get set}
    var artType:String { get }
    var place_of_origin: String { get set}
    var date: String { get set }
    var image_id: String { get set}
    var imageURL:URL? { get set}
    var imageSize : String { get set}
}

class HomeFeedVM : BaseViewModel, HomeFeedPresentable {
    var title: String
    var artist_display: String
    var artType: String
    var place_of_origin: String
    var date: String
    var image_id: String
    var imageURL: URL?
    var imageSize: String

    init(title:String?,
         artistName:String?,
         artType:String?,
         place:String?,
         date:String?,
         imageID:String?,
         imageURL:String?,imageSize:String){
        self.title = title ?? ""
        self.artist_display = artistName ?? ""
        self.artType = artType ?? ""
        self.place_of_origin = place ?? ""
        self.date = date ?? ""
        self.image_id = imageID ?? ""
        self.imageURL = URL(string:"\(imageURL!)/\(imageID ?? "")\(Endpoint.imageSuffix.rawValue)")
        self.imageSize = imageSize
    }
}
