//
//  HomeVM.swift
//  MVVMDemo
//
//  Created by sudhir on 22/06/22.
//

import Foundation

class HomeVM: BaseViewModel {
    private var httpUtility: HttpUtility!
    var page : BoxBind<Int> = BoxBind(1)
    var homeFeedList: BoxBind<[HomeFeedPresentable]> = BoxBind([])

    override init()
    {
        let objHttpUtility = HttpUtility(loading: LoadingView())
        self.httpUtility = objHttpUtility
    }
    
    override func onViewDidLoad() {
        apiCallForArtworkList()
    }
}

extension HomeVM {
    func apiCallForArtworkList(){
        let objArtworkAPIResourceAccessor = ArtworkAPIResourceAccessor(httpUtility: httpUtility)
        objArtworkAPIResourceAccessor.getArtworkList(page: page.value)
        { result in
            guard let data = result.data,
                  let config = result.config
            else {
                return
            }
            let _homefeedList =
            data.compactMap {
                artWork -> HomeFeedVM  in
                let homeFeedVM = HomeFeedVM(title: artWork.title,
                                            artistName: artWork.artistTitle,
                                            artType: artWork.artworkTypeTitle,
                                            place: artWork.placeOfOrigin,
                                            date: artWork.date,
                                            imageID: artWork.imageID,
                                            imageURL: config.imageURL,
                                            imageSize: "16.0/9.0")
                return homeFeedVM
            }
            self.homeFeedList.value.append(contentsOf: _homefeedList)
        }
    }
}
