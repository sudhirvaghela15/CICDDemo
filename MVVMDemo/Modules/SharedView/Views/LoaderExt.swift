//
//  Loader.swift
//  MVVMDemo
//
//  Created by sudhir on 26/06/22.
//

import UIKit
extension LoadingView {
    func showLoadingView() {
        DispatchQueue.main.async {
            let windowView = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
            if let loadingView = windowView?.viewWithTag(LoadingView.tagValue) as? LoadingView {
                loadingView.isLoading = true
            } else {
                let loadingView = LoadingView(frame: UIScreen.main.bounds)
                windowView?.addSubview(loadingView)
                loadingView.isLoading = true
            }
        }
    }

    func hideLoadingView() {
        DispatchQueue.main.async {
            let windowView = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
            windowView?.viewWithTag(LoadingView.tagValue)?.removeFromSuperview()
        }
    }
}
