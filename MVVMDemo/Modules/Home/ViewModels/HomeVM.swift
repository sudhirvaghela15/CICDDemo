//
//  HomeVM.swift
//  MVVMDemo
//
//  Created by sudhir on 22/06/22.
//

import Foundation

class HomeVM: BaseViewModel {
	
    private var httpClient: HTTPClient!
	var homeFeedList: BoxBind<[HomeFeedPresentable]> = BoxBind([])
	var artworkLoader: ArtworkLoader?
	
	/// propertiew
	var page : BoxBind<Int> = BoxBind(1)

	convenience init(session: HTTPClient = URLSessionHTTPClient(session: .shared)) {
		self.init()
		self.httpClient = session
		self.artworkLoader = ArtworkLoader(service: .getArtwork(QueryParams: ArtworkRequest(page: 10, limit: 10)), client: httpClient)
    }
}

extension HomeVM {
	func getArtwokrFromRemote() {
		self.isLoadingPublisher.value = true
		artworkLoader?.load(completion: {[weak self] result in
			switch result {
			case .success(let response):
				guard let data = response.data,
					  let config = response.config
				else { return }
				
				let _homefeedList =
				data.compactMap {
					artWork -> HomeFeedVM  in
					let homeFeedVM = HomeFeedVM(
						title: artWork.title,
						artistName: artWork.artistTitle,
						artType: artWork.artworkTypeTitle,
						place: artWork.placeOfOrigin,
						date: artWork.date,
						imageID: artWork.imageID,
						imageURL: config.imageURL,
						imageSize: "16.0/9.0"
					)
					return homeFeedVM
				}
				self?.homeFeedList.value.append(contentsOf: _homefeedList)
				self?.isLoadingPublisher.value = false
			case .failure(let error):
				self?.errorPublisher?.value = error
				self?.isLoadingPublisher.value = false
			}
		})
	}
}
