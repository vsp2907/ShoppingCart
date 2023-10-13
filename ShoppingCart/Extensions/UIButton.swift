//
//  UIButton.swift
//  ShoppingCart
//
//  Created by Deepak Dethliya on 12/10/23.
//

import UIKit

extension UIButton {
    /// Apply corner radius to the button.
    ///
    /// - Parameter size: The corner radius size.
    func cornerRadius(_ size: CGFloat) {
        self.layer.cornerRadius = size
    }
    
    /// Apply a border width to the button.
    ///
    /// - Parameter size: The border width size.
    func borderWidth(_ size: CGFloat) {
        self.layer.borderWidth = size
    }
    
    /// Underline the button's text.
    func underline() {
        guard let text = self.titleLabel?.text else { return }
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.underlineColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
        self.setAttributedTitle(attributedString, for: .normal)
    }
}
