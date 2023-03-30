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
    func onViewDidLoad()
    func onViewWillAppear()
    func onViewDidAppear()
    func onViewWillDisappear()
    func onViewDidDisappear()
}


class BaseViewModel : ViewModel {
    var isLoadingPublisher: BoxBind<Bool> = BoxBind(false)
    var errorPublisher: BoxBind<Error>? = nil

    func onViewDidLoad() { }
    
    func onViewWillAppear() { }
    
    func onViewDidAppear() { }
    
    func onViewWillDisappear() { }
    
    func onViewDidDisappear() { }
}
