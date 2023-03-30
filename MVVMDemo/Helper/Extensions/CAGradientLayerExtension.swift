//
//  File.swift
//  MVVMDemo
//
//  Created by sudhir on 22/06/22.
//

import UIKit
import Foundation
extension CAGradientLayer {
    func setGradientLayer(color1: UIColor, color2: UIColor, for containerView: UIView, cornerRadius: CGFloat, startPoint: CGPoint = CGPoint(x: 0.0, y: 0.0), endPoint: CGPoint = CGPoint(x: 1.0, y: 0.5)) {
        self.colors = [color1.cgColor, color2.cgColor]
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.frame = containerView.bounds
        self.cornerRadius = cornerRadius
    }
}
