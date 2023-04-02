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

    override init() {
        let objHttpUtility = HttpUtility(loading: LoadingView())
        self.httpUtility = objHttpUtility
    }
}

extension HomeVM {
	func getArtwokrFromRemote() {
		
	}
}
