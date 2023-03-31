//
//  BaseViewMode.swift
//  MVVMDemo
//
//  Created by sudhir on 26/06/22.
//

import Foundation

protocol ViewModel {
    var  isLoadingPublisher: BoxBind<Bool> { get }
    var  errorPublisher: BoxBind<Error>? { get }
	// MARK: - required method
}


class BaseViewModel: ViewModel {
    var isLoadingPublisher: BoxBind<Bool> = BoxBind(false)
    var errorPublisher: BoxBind<Error>? = nil

	deinit {
		debugPrint("deinit of ", String(describing: self))
	}
}
