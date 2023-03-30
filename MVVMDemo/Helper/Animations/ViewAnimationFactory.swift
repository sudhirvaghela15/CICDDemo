//
//  Animation Factory.swift
//  MVVMDemo
//
//  Created by sudhir on 22/06/22.
//
import UIKit

enum ViewAnimationFactory {
    static func makeEaseInAnimation(duration: TimeInterval, delay: TimeInterval, action: @escaping() -> Void) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
            action()
        })
    }
    static func makeEaseInOutAnimation(duration: TimeInterval, delay: TimeInterval, action: @escaping() -> Void) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseInOut, animations: {
            action()
        })
    }
    static func makeEaseOutAnimation(duration: TimeInterval, delay: TimeInterval, action: @escaping() -> Void) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseOut, animations: {
            action()
        })
    }
    
    static func makeSimpleAnimation(duration: TimeInterval, action: @escaping() -> Void){
        UIView.animate(withDuration: duration) {
            action()
        }
    }
}
