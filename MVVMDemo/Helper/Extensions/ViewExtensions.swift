//
//  ViewExtensions.swift
//  Box_MVVM
//
//  Created by sudhir on 11/06/22.
//

import UIKit

extension UIView {
    
    /// For setting gradient of the TextField
    func setGradientText(parent: UIView, color1: UIColor = UIColor.systemPink, color2: UIColor = UIColor.systemPurple) {
        let view = UIView(frame: self.frame)
        parent.addSubview(view)
        let gradient = CAGradientLayer()
        gradient.setGradientLayer(color1: color1, color2: color2, for: self, cornerRadius: 0)
        
        view.layer.addSublayer(gradient)
        view.addSubview(self)
        view.layer.mask = self.layer
    }

    func setShadow(shadowColor: UIColor, shadowOpacity: Float, shadowRadius: CGFloat, offset: CGSize) {
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOffset = offset
    }
    
    func setOpacity(to opacity: Float) {
        self.layer.opacity = opacity
    }
    
    func setBorder(with color: UIColor, _ width: CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
    /// For rounding the corners of the view
    func roundCorners(cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }

    /// for setting cornerRadius and borderWidth
    func setBorderAndCorner(borderColor: UIColor, borderWidth: CGFloat, cornerRadius: CGFloat) {
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
    }

    func setBorder(with color: UIColor, width: CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
}

extension UITextField {
    /// For setting gradient of the TextField
    func _setGradientText(parent: UIView, color1: UIColor = UIColor.systemPink, color2: UIColor = UIColor.systemPurple) {
        let view = UIView(frame: self.frame)
        parent.addSubview(view)
        let gradient = CAGradientLayer()
        gradient.setGradientLayer(color1: color1, color2: color2, for: self, cornerRadius: 0)
        
        view.layer.addSublayer(gradient)
        view.addSubview(self)
        view.layer.mask = self.layer
    }
}

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



