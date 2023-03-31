//
//  UIFontExtension.swift
//  Box_MVVM
//
//  Created by sudhir on 11/06/22.
//

import UIKit


extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension CGFloat {
    func degreeToRadians() -> CGFloat {
        return (self * .pi) / 180
    }
}

extension Double {
    func roundToPlaces(places: Int) -> Double{
        let divisor = Double(truncating: NSDecimalNumber(decimal: pow(10, places)))
        return ((divisor * self).rounded() / divisor)
    }
}

extension Int {
    func appendZeros() -> String {
        if (self < 10) {
            return "0\(self)"
        } else {
            return "\(self)"
        }
    }
}
