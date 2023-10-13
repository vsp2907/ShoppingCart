//
//  CartViewController.swift
//  ShoppingCart
//
//  Created by Deepak Dethliya on 12/10/23.
//

import UIKit
import Toast
protocol CartTableViewCellDelegate: AnyObject {
    func actionApplyRemovePromocode(_ cell: CartTableViewCell, didTapApplyPromoCode index: Int)
}
class CartViewController: UIViewController {
    // MARK: - Variable
    private lazy var viewModel: CartViewModel = {
        return CartViewModel()
    }()
    
    // MARK: - Outlet
    @IBOutlet weak var btnCheckout: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblNoItems: UILabel!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindViewModel()
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        // Apply a gradient background to the checkout button
        btnCheckout.applyGradientBackground(cornerRadius: 4)
        
        // Set the data source for the table view
        tableView.dataSource = self
        
        // Register cell types for the table view
        viewModel.registerCell(CartTableViewCell.self, in: tableView) // Register CartTableViewCell
        viewModel.registerCell(CartPriceDetailTableViewCell.self, in: tableView) // Register CartPriceDetailTableViewCell
        
        // Customize the navigation bar title text color
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    // MARK: - View Model Binding
    private func bindViewModel() {
        viewModel.didShowToastMessage = { [weak self] (message) in
            DispatchQueue.main.async {
                self?.view.makeToast(message, duration: 1, position: .center)
            }
        }
        viewModel.didShowAlert = { [weak self] (title, message, isWithCancel) in
            self?.viewModel.showAlert(viewController: self, title: title, message: message)
        }
        // Bind to cartItemsDidChange to update the view based on cart items
        viewModel.cartItemsDidChange = { [weak self] cartItems, index in
            // Show/hide UI elements based on cart items
            self?.btnCheckout.isHidden = cartItems.isEmpty ? true : false
            self?.tableView.isHidden = cartItems.isEmpty ? true : false
            self?.lblNoItems.isHidden = cartItems.isEmpty ? false : true
            
            // Reload the table view to reflect changes in cart items
            guard index >= 0, index < cartItems.count else {
                self?.tableView.reloadData()
                return
            }
            self?.tableView.reloadRows(at: [IndexPath.init(row: index, section: 0), IndexPath.init(row: 0, section: 1)], with: .automatic)
        }
        
        // Load cart items from the view model
        viewModel.loadCartItems()
    }
    
    // MARK: - Action
    @IBAction func actionCheckout(_ sender: AnyObject) {
        // Handle the action when the checkout button is tapped
    }
    
    @objc func actionShowPromoCode(_ sender: UIButton) {
        // Handle the action to show promo code for a specific item
        viewModel.showPromoCodeView(at: sender.tag)
    }
    
    @objc func actionDeleteItem(_ sender: UIButton) {
        // Handle the action to delete an item from the cart
        self.showAlertWithCancel(message: "Are you sure to remove this item from the Shopping Cart?") { isYes in
            if isYes {
                self.viewModel.deleteCartItem(at: sender.tag)
            }
        }
    }
}

// MARK: - TableView DataSource
extension CartViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        // Get the number of sections from the view model
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Get the number of rows in the specified section from the view model
        return viewModel.numberOfRows(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get the cell for the specified index path from the view model
        return viewModel.cellForRowAt(tableView, indexPath: indexPath, target: self)
    }
}
