//
//  File.swift
//  MVVMDemo
//
//  Created by Sudhir Vaghela on 30/03/23.
//

import SwiftyUserDefaults


//var data: [ArtworkDetailModel]?
extension DefaultsKeys {
	var artDetails: DefaultsKey<ArtworkResponse?> { return .init("ArtworkResponse") }
}

class DefaultHelper {
	
	static var details: ArtworkResponse? = Defaults[keyPath: \.artDetails] {
		didSet {
			Defaults[\.artDetails] = details
		}
	}
}
