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
    
    private var productsInCart: [Product] = []
    
    //MARK: - Cart
    
    /// Add product that user selected to cart array
    public func addProductToCart(product: Product) {
        productsInCart.append(product)
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
    public func getProductsInCart() -> [Product] {
        return productsInCart
    }
    
    /// Calculate total amount to pay ( need to add multiplier after adding stepper )
    public func calculateTotal() -> String {
        var total = 0
        for i in 0..<productsInCart.count {
            total += Int(productsInCart[i].productPrice) ?? 0
        }
        return String(total)
    }
    
}
