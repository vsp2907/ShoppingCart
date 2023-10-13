//
//  CartTableViewCell.swift
//  ShoppingCart
//
//  Created by Deepak Dethliya on 12/10/23.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    // MARK: - Variable
    weak var delegate: CartTableViewCellDelegate?
    var currentIndex: Int?
    var cartItem: CartList.CartItem? {
        didSet {
            guard let cartItem else {
                return
            }
            // Set UI elements with cart item data
            lblProductName.text = cartItem.productName
            if cartItem.isPromoCodeApplied == true {
                let gradientPromocode = getGradientLayer(bounds: lblPromoCode.bounds)
                lblPromoCode.textColor = gradientColor(bounds: lblPromoCode.bounds, gradientLayer: gradientPromocode)
                lblProductPrice.text = formatPriceAndDiscount(price: cartItem.productPrice, discount: cartItem.productPromoDiscount ?? 0.0, isShowOnlyDiscountedPrice: true)
                lblPriceStrike.text = "₹ \(cartItem.productPrice)"
                lblDiscountPerOff.text = formatPriceAndDiscount(price: cartItem.productPrice, discount: cartItem.productPromoDiscount ?? 0.0, isShowOnlyDiscountedPrice: false)
            } else {
                lblPromoCode.textColor = .appGreenLight
                lblProductPrice.text = "₹ \(cartItem.productPrice)"
            }
            
            lblProductSize.text = cartItem.productSize
            lblProductQty.text = "\(cartItem.productQty)"
            lblProductSeller.text = cartItem.productSeller
            lblETA.text = cartItem.productETA
            txtPromoCode.text = cartItem.isPromoCodeApplied == true ? "\(cartItem.productPromoCode ?? "") \(formatPriceAndDiscount(price: cartItem.productPrice, discount: cartItem.productPromoDiscount ?? 0.0, isShowOnlyDiscountedPrice: false, isShowOff: false))" : ""
            
            // Configure visibility of promo code view, apply button, and other UI elements based on cart item properties
            viewPromoCode.isHidden = cartItem.isPromoCodeApplied == true ? false : cartItem.isShowPromoCodeView == true ? false : true
            btnApplyPromoCode.isHidden = (cartItem.isPromoCodeApplied == true || cartItem.isShowPromoCodeView == true) ? true : false
            lblPriceStrike.isHidden = cartItem.isPromoCodeApplied == true ? false : true
            lblDiscountPerOff.isHidden = cartItem.isPromoCodeApplied == true ? false : true
         
            btnApplyRemoveCode.titleLabel?.text = cartItem.btnPromoCodeTitle
            btnApplyRemoveCode.underline()
            //
            
            let gradient = getGradientLayer(bounds: txtPromoCode.bounds)
            txtPromoCode.textColor = gradientColor(bounds: txtPromoCode.bounds, gradientLayer: gradient)
            
            let gradientButton = getGradientLayer(bounds: btnApplyRemoveCode.bounds)
            btnApplyRemoveCode.setTitleColor(gradientColor(bounds: btnApplyRemoveCode.bounds, gradientLayer: gradientButton), for: .normal)
        }
    }
    
    // MARK: - Outlet
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProductPrice: UILabel!
    @IBOutlet weak var lblProductSize: UILabel!
    @IBOutlet weak var lblProductQty: UILabel!
    @IBOutlet weak var lblProductSeller: UILabel!
    @IBOutlet weak var lblETA: UILabel!
    @IBOutlet weak var btnApplyPromoCode: UIButton!
    @IBOutlet weak var viewPromoCode: UIView!
    @IBOutlet weak var viewInternalPromoCode: UIView!
    @IBOutlet weak var txtPromoCode: UITextField!
    @IBOutlet weak var btnApplyRemoveCode: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var lblPriceStrike: UILabel!
    @IBOutlet weak var lblDiscountPerOff: UILabel!
    @IBOutlet weak var lblPromoCode: UILabel!

    // MARK: - Awake From Nib
    override func awakeFromNib() {
        super.awakeFromNib()
        // Add strikethrough style to lblPriceStrike
        let attributedString = NSMutableAttributedString(string: lblPriceStrike.text ?? "")
        attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attributedString.length))
        lblPriceStrike.attributedText = attributedString
       
        // Add Apply|Remove promocode button action
        btnApplyRemoveCode.addTarget(target, action: #selector(self.actionApplyPromoCode), for: .touchUpInside)
        //viewPromoCode.setGradientBorder(width: 1.0, cornerRadius: 4)

    }
    
    // MARK: - format price and Discount
    func formatPriceAndDiscount(price: Double, discount: Double, isShowOnlyDiscountedPrice: Bool, isShowOff: Bool = true) -> String {
        let discountedPrice = price - (price * (discount / 100))
        
        let priceFormatter = NumberFormatter()
        priceFormatter.numberStyle = .currency
        priceFormatter.currencySymbol = "₹ "
        priceFormatter.minimumFractionDigits = 0
        priceFormatter.maximumFractionDigits = 2
        
        let formattedPrice = priceFormatter.string(from: NSNumber(value: discountedPrice)) ?? "₹ 0.00"
        if isShowOnlyDiscountedPrice {
            return "\(formattedPrice)"
        } else {
            return isShowOff ? " (\(Int(discount))% off)" : " (\(Int(discount))% discount)"
        }
    }
    
    // MARK: - Action
    @objc func actionApplyPromoCode(_ sender: UIButton){
        guard let currentIndex else {
            return
        }
        delegate?.actionApplyRemovePromocode(self, didTapApplyPromoCode: currentIndex)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

extension CartTableViewCell {
    func gradientColor(bounds: CGRect, gradientLayer :CAGradientLayer) -> UIColor? {
    //We are creating UIImage to get gradient color.
          UIGraphicsBeginImageContext(gradientLayer.bounds.size)
          gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
          let image = UIGraphicsGetImageFromCurrentImageContext()
          UIGraphicsEndImageContext()
          return UIColor(patternImage: image!)
    }
}
