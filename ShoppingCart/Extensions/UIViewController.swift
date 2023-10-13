//
//  UIViewController.swift
//  ShoppingCart
//
//  Created by Deepak Dethliya on 13/10/23.
//

import UIKit

// MARK: - Show Alert
extension UIViewController{
    func showAlertWithCancel(_ title: String? = "Message", message: String?, btnTitle1: String = "OK", cancelTitle: String = "Cancel" , completion: @escaping (_ isYes: Bool) -> Void) -> Void {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: btnTitle1, style: UIAlertAction.Style.default) { alert in
                completion(true)
            })
            alert.addAction(UIAlertAction(title: cancelTitle, style: UIAlertAction.Style.cancel) { alert in
                completion(false)
            })
            self.present(alert, animated: true)
        }
    
    func showAlert(_ title: String? = "Message", message: String?, buttonTitle: String = "OK" ,completion: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default) { alert in
            completion?()
        })
        self.present(alert, animated: true)
    }
}
