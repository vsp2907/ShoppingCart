//
//  CartPriceDetailTableViewCell.swift
//  ShoppingCart
//
//  Created by Deepak Dethliya on 12/10/23.
//

import UIKit

class CartPriceDetailTableViewCell: UITableViewCell {
    // MARK: - Variable
    var cartItems: [CartList.CartItem]? {
        didSet {
            guard let cartItems else {
                return
            }
            
            // Calculate the total original price, coupon discount, and total price after discount
            var couponDiscountPrice = 0
            let totalOriginalPrice = cartItems.reduce(0) { $0 + $1.productPrice }
            var totalPriceAfterDiscount = totalOriginalPrice
            let promoItems = cartItems.filter { $0.isPromoCodeApplied == true }
            
            // Iterate through promo items to calculate discounts and coupon discount
            for promoItem in promoItems {
                let discountedPrice = promoItem.productPrice * ((promoItem.productPromoDiscount ?? 0.0) / 100)
                couponDiscountPrice += Int(discountedPrice)
                totalPriceAfterDiscount -= discountedPrice
            }
            
            // Calculate tax (5% of the total original price)
            let tax = (totalOriginalPrice / 100) * 5
            
            // Update labels with calculated values
            lblTax.text = "₹ \(String(format: "%.2f", tax))" // Format tax with two decimal places
            lblPrice.text = "₹ \(String(format: "%.2f", totalOriginalPrice))" // Format total price with two decimal places
            lblTotal.text = "₹ \(String(format: "%.2f", totalPriceAfterDiscount + tax))" // Format total with two decimal places
            lblCouponDiscount.text = "- ₹ \(couponDiscountPrice)"
        }
    }
    // MARK: - Outlet
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDeliveryCharge: UILabel!
    @IBOutlet weak var lblCouponDiscount: UILabel!
    @IBOutlet weak var lblTax: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
