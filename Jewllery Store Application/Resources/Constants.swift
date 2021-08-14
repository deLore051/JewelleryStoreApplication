//
//  Constants.swift
//  Jewllery Store Application
//
//  Created by Stefan Dojcinovic on 10.8.21..
//

import Foundation

struct K {
    
    struct FStore {
        struct Products {
            static let productCollectionName = "products"
            static let productName = "productName"
            static let productDescription = "description"
            static let productId = "productId"
            static let productImage = "productImage"
            static let productPrice = "productPrice"
            static let productCategory = "category"
        }
        struct User {
            static let userInfoCollectionName = "userInfo"
            static let firstName = "firstName"
            static let lastName = "lastName"
            static let countryName = "country"
            static let cityName = "city"
            static let email = "email"
        }
    }
    
    struct FStorage {
        static let braceletsRefName = "bracelets"
        static let earringsRefName = "earrings"
        static let necklaceRefName = "necklaces"
        static let ringsRefName = "rings"
        static let watchesRefName = "watches"
    }
    
}
