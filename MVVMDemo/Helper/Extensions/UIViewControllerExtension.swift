//
//  UIViewControllerExtension.swift
//  MVVMDemo
//
//  Created by Sudhir Vaghela on 31/03/23.
//

import UIKit

extension UIViewController  {
	static var className: String {
		return String(describing: self)
	}
}


extension UIViewController {
	/// hide nav bar
	func setNavigationBar (hidden isHidden: Bool) {
		self.navigationController?.setNavigationBarHidden(isHidden, animated: false)
	}
}
