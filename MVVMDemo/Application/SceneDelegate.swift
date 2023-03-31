//
//  SceneDelegate.swift
//  MVVMDemo
//
//  Created by sudhir on 22/06/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let scene = (scene as? UIWindowScene) else { return }
		
		self.window = UIWindow(windowScene: scene)
		
		let rootview: HomeVC = UIStoryboard.get(.feed).instantiate()
		
		window?.rootViewController = UINavigationController(rootViewController: rootview)
		window?.makeKeyAndVisible()
    }

}

