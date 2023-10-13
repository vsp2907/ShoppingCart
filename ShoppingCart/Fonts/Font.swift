//
//  Font.swift
//  ShoppingCart
//
//  Created by Deepak Dethliya on 12/10/23.
//

import UIKit

// MARK: - WorkSans Font Sizes
enum FontSize: CGFloat {
    case size10 = 10.0
    case size12 = 12.0
    case size14 = 14.0
    case size16 = 16.0
    case size19 = 19.0
}

// MARK: - WorkSans Custom Fonts
extension UIFont {
    enum WorkSans: String {
        case regular = "WorkSans-Regular"
        case medium = "WorkSans-Medium"
        
        func size(_ size: CGFloat) -> UIFont {
            return UIFont(name: self.rawValue, size: size)!
        }
    }
}

