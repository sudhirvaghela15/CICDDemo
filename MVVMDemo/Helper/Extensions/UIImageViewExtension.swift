//
//  UIImageView+Ext.swift
//  MVVMDemo
//
//  Created by Sudhir Vaghela on 31/03/23.
//

import UIKit

extension UIImageView {
	func load(url: URL) {
		DispatchQueue.global().async { [weak self] in
			if let data = try? Data(contentsOf: url) {
				if let image = UIImage(data: data) {
					DispatchQueue.main.async {
						self?.image = image
					}
				}
			}
		}
	}
}
