//
//  CartModel.swift
//  ShoppingCart
//
//  Created by Deepak Dethliya on 12/10/23.
//

import Foundation
struct CartList : Codable {
    // JSON data containing cart items
    var jsonString = """
    [
      {
        "id": 1,
        "productName": "Burberry T-shirt",
        "productSize": "Medium",
        "productQty": 2,
        "productPrice": 1000.0,
        "productSeller": "Blueberry store",
        "productETA": "ETA 5-7 working days",
        "productPromoCode": "4monks",
        "productPromoDiscount": 10,
        "isPromoCodeApplied": false,
        "isShowPromoCodeView": false,
        "btnPromoCodeTitle": "Apply"
      },
      {
        "id": 2,
        "productName": "Burberry T-shirt",
        "productSize": "Medium",
        "productQty": 2,
        "productPrice": 3000.0,
        "productSeller": "Seller 2 name 2",
        "productETA": "ETA 5-7 working days",
        "productPromoCode": "4monks",
        "productPromoDiscount": 30,
        "isPromoCodeApplied": false,
        "isShowPromoCodeView": false,
        "btnPromoCodeTitle": "Apply"
      },
      {
        "id": 3,
        "productName": "Burberry T-shirt",
        "productSize": "Medium",
        "productQty": 2,
        "productPrice": 5000.0,
        "productSeller": "Seller 2 name 2",
        "productETA": "ETA 5-7 working days",
        "productPromoCode": "4monks",
        "productPromoDiscount": 20,
        "isPromoCodeApplied": false,
        "isShowPromoCodeView": false,
        "btnPromoCodeTitle": "Remove"
      }
    ]
    """
    // Cart item structure conforming to Codable
    struct CartItem: Codable {
        var id: Int
        var productName: String
        var productSize: String
        var productQty: Int
        var productPrice: Double
        var productSeller: String
        var productETA: String
        var productPromoCode: String?
        var productPromoDiscount: Double?
        var isPromoCodeApplied: Bool?
        var isShowPromoCodeView: Bool?
        var btnPromoCodeTitle: String?
    }
    
    // Function to return cart items
    func getCartItems() -> [CartItem]? {
        if let jsonData = jsonString.data(using: .utf8) {
            do {
                let cartItems = try JSONDecoder().decode([CartItem].self, from: jsonData)
                return cartItems
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        return nil
    }
}
