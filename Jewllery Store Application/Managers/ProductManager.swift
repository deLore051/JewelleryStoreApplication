//
//  ProductManager.swift
//  Jewllery Store Application
//
//  Created by Stefan Dojcinovic on 13.8.21..
//

import Foundation

final class ProductManager {
    
    static let shared = ProductManager()
    
    private init() {  }
    
    private var productsInCart: [CartReusableTableViewCellViewModel] = []
    
    //MARK: - Cart
    
    /// Add product that user selected to cart array or increase the number of certain product that is already in the array
    public func addProductToCart(model: Product) {
        checkIfProductIsInCart(with: model.productName) { [weak self] result in
            guard let self = self else { return }
            guard let result = result else {
                self.productsInCart.append(CartReusableTableViewCellViewModel(
                                            product: model,
                                            numberOfProducts: 1))
                return
            }
            self.productsInCart[result].numberOfProducts += 1
        }
    }
    
    /// Check if productsInCart array contains an item with a certain name, if it does return its position in array else return nil
    private func checkIfProductIsInCart(with name: String, completion: @escaping (Int?) -> Void) {
        guard productsInCart.count != 0 else {
            completion(nil)
            return
        }
        for i in 0..<productsInCart.count {
            guard productsInCart[i].product.productName != name else {
                completion(i)
                return
            }
        }
        completion(nil)
    }
    
    /// Remove selected product from cart array
    public func removeProductFromCart(at position: Int) {
        productsInCart.remove(at: position)
    }
    
    /// Clear all products from cart array
    public func clearCartTable() {
        productsInCart.removeAll()
    }
    
    /// Returnes an array of product objects that user added to cart from home or search screen
    public func getProductsInCart() -> [CartReusableTableViewCellViewModel] {
        return productsInCart
    }
    
    
    /// Calculate total amount to pay ( need to add multiplier after adding stepper )
    public func calculateTotal() -> String {
        var total = 0
        for i in 0..<productsInCart.count {
            total += ((Int(productsInCart[i].product.productPrice) ?? 0) * productsInCart[i].numberOfProducts)
        }
        return String(total)
    }
    
    public func updateStepperValue(at position: Int, value: Int) {
        self.productsInCart[position].numberOfProducts = value
    }
    
    //MARK: - Search
    
    /// Return all products that contain the query string in the products name
    public func search(with query: String) -> [Product] {
        var searchResults: [Product] = []
        let products = APICaller.shared.products
        for product in products {
            if product.productName.lowercased().contains(query.lowercased()) {
                searchResults.append(product)
            }
        }
        return searchResults
    }
    
    //MARK: - Category
    
    /// Get all products of selected category
    public func getProducts(for category: String) -> [Product] {
        var productsInCategory: [Product] = []
        let products = APICaller.shared.products
        for product in products {
            if product.productCategory.lowercased() == category.lowercased() {
                productsInCategory.append(product)
            }
        }
        
        return productsInCategory
    }
    
}
