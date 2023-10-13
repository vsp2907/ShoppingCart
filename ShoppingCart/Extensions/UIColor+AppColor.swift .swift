//
//  UIColor+AppColor.swift .swift
//  ShoppingCart
//
//  Created by Deepak Dethliya on 12/10/23.
//

import UIKit

// MARK: - Predefined Colors
extension UIColor {
    /// Background color for the app.
    static var appBackground: UIColor {
        return UIColor(named: "AppBackground")!
    }
    
    /// Dark gray color for the app.
    static var appDarkGray: UIColor {
        return UIColor(named: "AppDarkGray")!
    }
    
    /// Gray color for the app.
    static var appGray: UIColor {
        return UIColor(named: "AppGray")!
    }
    
    /// Green color for the app.
    static var appGreen: UIColor {
        return UIColor(named: "AppGreen")!
    }
    
    /// Green Light color for the app.
    static var appGreenLight: UIColor {
        return UIColor(named: "AppGreenLight")!
    }
    
    /// Mint green color for the app.
    static var appMintGreen: UIColor {
        return UIColor(named: "AppMintGreen")!
    }
    
    /// Text gray color for the app.
    static var appTxtGray: UIColor {
        return UIColor(named: "AppTxtGray")!
    }
    
    /// Separator gray color for the app.
    static var appSeparatorGray: UIColor {
        return UIColor(named: "AppSeparatorGray")!
    }
}

// MARK: - Convenience Init from Hex
extension UIColor {
    /// Creates a UIColor instance from a hex string.
    ///
    /// - Parameter hex: The hex string representation of the color (e.g., "#RRGGBB").
    /// - Returns: A UIColor instance.
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

