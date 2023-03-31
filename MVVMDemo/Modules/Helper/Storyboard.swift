//
//  Storyboard.swift
//  MVVMDemo
//
//  Created by Sudhir Vaghela on 31/03/23.
//

import UIKit

enum Storyboard: String {
	case feed = "Home"
}

extension UIStoryboard {
	
	class func get(_ storyboard: Storyboard) -> UIStoryboard {
		return UIStoryboard(name: storyboard.rawValue, bundle: Bundle.main)
	}
	
	func instantiate<T: UIViewController>() -> T {
		return self.instantiateViewController(withIdentifier: String(describing: T.self)) as? T ?? T.init()
	}
	
}
