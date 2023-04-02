//
//  ArtworkAPIRepository.swift
//  MVVMDemo
//
//  Created by sudhir on 23/06/22.
//

import UIKit

struct ArtworkAPIResourceAccessor  {
    
    private let httpUtility: HttpUtility!
    init(httpUtility : HttpUtility)
    {
        self.httpUtility = httpUtility
    }
    
    func getArtworkList(page:Int,complition:@escaping(ArtworkResponse)->Void){
        print("_____________")
		let request = ArtworkRequest.build(page: page)
        
        debugPrint("ArtworkRequest \(request)")
        let url = URL(string: "\(Endpoint.baseUrl.rawValue)\(Endpoint.artworks.rawValue)")!
        var urlComponent = URLComponents(url: url,resolvingAgainstBaseURL: false)
            urlComponent?.queryItems = try! request.convertToURLQueryItems()
    
        httpUtility.getApiData(requestUrl: (urlComponent?.url!)!, resultType:ArtworkResponse.self) { result in
            guard let result = result else {
                return
            }
			DefaultHelper.details = result
            debugPrint(result.data?.count ?? "0")
            complition(result)
        }
    }
}


struct ArtworkRepo {
	
	private let client: HTTPClient
	
	init(client: HTTPClient) {
		self.client = client
	}
	
	
	func getArtworkList(request: ArtworkRequest = ArtworkRequest.build(), completion: @escaping RemoteResultCallback) {
		
		var urlComponent = URLComponents(
			url: URL(string: "\(Endpoint.baseUrl.rawValue)\(Endpoint.artworks.rawValue)")!,
			resolvingAgainstBaseURL: false
		)
			urlComponent?.queryItems = try! request.convertToURLQueryItems()
		
		client.get(from: (urlComponent?.url)!, completion: completion)
		
	}
}





// MARK: -  Helper
typealias RemoteResultCallback = (HTTPClient.Result) -> Void
