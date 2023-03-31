//
//  BaseView.swift
//  MVVMDemo
//
//  Created by Sudhir Vaghela on 31/03/23.
//

import UIKit
class BaseView: UIView {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setup()
	}
	
	func configureNib() {
		backgroundColor = .clear
		addSubview(getNib() ?? UIView())
	}
	
	func setup() {}
	
}
