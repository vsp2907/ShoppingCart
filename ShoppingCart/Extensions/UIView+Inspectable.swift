//
//  UIView+Inspectable.swift
//  ShoppingCart
//
//  Created by Deepak Dethliya on 12/10/23.
//

import UIKit

/// A UIView subclass that allows for setting design properties in Interface Builder (IB).
@IBDesignable
class DesignableView: UIView {}

extension UIView {
    /// The corner radius of the view.
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    /// The border width of the view.
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    /// The border color of the view.
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    /// The shadow radius of the view.
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
            self.layer.masksToBounds = false
        }
    }
    
    /// The shadow opacity of the view.
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    /// The shadow offset of the view.
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    /// The shadow color of the view.
    @IBInspectable var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}

extension UIView {
    /// Apply a gradient background to the view.
    ///
    /// - Parameters:
    ///   - hexColors: An array of hex color strings to create the gradient.
    ///   - startPoint: The starting point of the gradient.
    ///   - endPoint: The ending point of the gradient.
    ///   - cornerRadius: The corner radius of the view.
    func applyGradientBackground(colors: [UIColor] = [
        UIColor(red: 0.745, green: 0.992, blue: 0.31, alpha: 1),  UIColor(red: 0.506, green: 0.984, blue: 0.725, alpha: 1)
    ], startPoint: CGPoint = CGPoint(x: 1.0, y: 0.5), endPoint: CGPoint = CGPoint(x: 0.5, y: 0.5), cornerRadius: CGFloat) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.locations = [0, 1]
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.cornerRadius = cornerRadius
        gradientLayer.bounds = self.bounds.insetBy(dx: -0.5*self.bounds.size.width, dy: -0.5*self.bounds.size.height)
         layer.insertSublayer(gradientLayer, at: 0)
    }
    func setGradientBorder(width: CGFloat, cornerRadius: CGFloat) {
        // Create a gradient layer
        let gradientLayer = getGradientLayer(bounds: self.bounds)

        // Create a shape layer to act as a mask for the gradient border
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        maskLayer.fillColor = UIColor.clear.cgColor
        maskLayer.strokeColor = UIColor.black.cgColor
        maskLayer.lineWidth = width
        gradientLayer.mask = maskLayer

        // Add the gradient layer as a sublayer
        layer.addSublayer(gradientLayer)
    }
    func getGradientLayer(bounds : CGRect) -> CAGradientLayer{
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [
            UIColor(red: 0.506, green: 0.984, blue: 0.725, alpha: 1).cgColor,
            UIColor(red: 0.745, green: 0.992, blue: 0.31, alpha: 1).cgColor
            ]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        return gradient
    }
}
