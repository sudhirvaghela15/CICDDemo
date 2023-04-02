//
//  MainQueueDispatchDecorator.swift
//  MVVMDemo
//
//  Created by Sudhir Vaghela on 31/03/23.
//

import Foundation

final class MainQueueDispatchDecorator<T> {
	internal let decoratee: T
	
	init(decoratee: T) {
		self.decoratee = decoratee
	}
	
	func dispatch(completion: @escaping () -> Void) {
		guard Thread.isMainThread else {
			return DispatchQueue.main.async(execute: completion)
		}
		completion()
	}
	
	func dispatch(with delay: DispatchTime, completion: @escaping () -> Void) {
		return DispatchQueue.main.asyncAfter(deadline: delay, execute: completion)
	}
}
