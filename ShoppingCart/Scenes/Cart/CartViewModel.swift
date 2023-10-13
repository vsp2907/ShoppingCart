//
//  CartViewModel.swift
//  ShoppingCart
//
//  Created by Deepak Dethliya on 12/10/23.
//
import UIKit

class CartViewModel {
    // MARK: - Variables
    var cartItems: [CartList.CartItem] = []
    var cartItemsDidChange: (([CartList.CartItem], Int) -> Void)?
    var didShowAlert: ((String, String, Bool) -> Void)?
    var didShowToastMessage: ((String) -> Void)?
    
    // MARK: - Load Cart Items
    func loadCartItems() {
        if let items = CartList().getCartItems() {
            cartItems = items
            cartItemsDidChange?(cartItems, 0)
        }
    }
    
    // MARK: - Register Cells
    func registerCell<T: UITableViewCell>(_ cellType: T.Type, in tableView: UITableView) {
        let nibName = String(describing: cellType)
        tableView.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }
    
    // MARK: - Show PromoCode Field
    func showPromoCodeView(at index: Int){
        // Implement code to show promo code field and update the cartItems.
        self.cartItems[index].isShowPromoCodeView = true
        self.cartItems[index].btnPromoCodeTitle = "Apply"
        cartItemsDidChange?(self.cartItems, index)
    }
    
    // MARK: - Delete an Item
    func deleteCartItem(at index: Int) {
        guard index >= 0, index < cartItems.count else {
            return // Ensure the index is valid
        }
        cartItems.remove(at: index)
        // Notify the view to update
        cartItemsDidChange?(cartItems, index)
        self.didShowToastMessage?("The item has been removed from your shopping cart.")
    }
    // Show Alert
    func showAlert(viewController: UIViewController?, title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            // Handle the OK button action, if needed
        }
        
        alertController.addAction(okAction)
        
        viewController?.present(alertController, animated: true, completion: nil)
    }
}

// MARK: - CartViewModel Extension
extension CartViewModel {
    var numberOfSections: Int {
        // Return the number of sections in my table view
        return 2
    }
    
    func numberOfRows(inSection section: Int) -> Int {
        switch section {
        case 0:
            return cartItems.count
        case 1:
            return 1 // Assuming one cell in section 1 (e.g., price details)
        default:
            return 0
        }
    }
    
    func cellForRowAt(_ tableView: UITableView, indexPath: IndexPath, target: CartViewController) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CartTableViewCell.self), for: indexPath) as! CartTableViewCell
            cell.delegate = self
            cell.currentIndex = indexPath.row
            cell.cartItem = cartItems[indexPath.row]
            cell.btnApplyPromoCode.tag = indexPath.row
            cell.btnApplyPromoCode.addTarget(target, action: #selector(target.actionShowPromoCode), for: .touchUpInside)
            cell.btnDelete.tag = indexPath.row
            cell.btnDelete.addTarget(target, action: #selector(target.actionDeleteItem), for: .touchUpInside)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CartPriceDetailTableViewCell.self), for: indexPath) as! CartPriceDetailTableViewCell
            cell.cartItems = self.cartItems
            return cell
        }
    }
}

// MARK: - Apply Coupon | Remove Coupon Cell Delegate
extension CartViewModel: CartTableViewCellDelegate {
    func actionApplyRemovePromocode(_ cell: CartTableViewCell, didTapApplyPromoCode index: Int) {
        if self.cartItems[index].isPromoCodeApplied == true {
            self.cartItems[index].isPromoCodeApplied = false
            self.cartItems[index].isShowPromoCodeView = false
            self.cartItems[index].btnPromoCodeTitle = "Apply"
            self.cartItemsDidChange?(self.cartItems, index)
        } else {
            guard let text = cell.txtPromoCode.text, !text.isEmpty else {
                didShowAlert?("Message", "Please enter the promocode", false)
                return
            }
            guard cell.txtPromoCode.text == self.cartItems[index].productPromoCode else {
                didShowAlert?("Invalid Promo Code", "The entered promo code is not valid. Please try again.", false)
                return
            }
            self.cartItems[index].isPromoCodeApplied = true
            self.cartItems[index].isShowPromoCodeView = false
            self.cartItems[index].btnPromoCodeTitle = "Remove"
            self.cartItemsDidChange?(self.cartItems, index)
            self.didShowToastMessage?("Applied")
        }
    }
}
