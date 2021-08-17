//
//  APICaller.swift
//  Jewllery Store Application
//
//  Created by Stefan Dojcinovic on 10.8.21..
//

import Foundation
import Firebase

final class APICaller {
    
    static let shared = APICaller()
    
    private init() { }
    
    private let storage = Storage.storage()
    private let db = Firestore.firestore()
    public var products: [Product] = []
    public var model: [[Product]] = [[]]
    
    //MARK: - Product section
    
    /// Obtain snapshot of documents with product data
    public func getProductsFromFirestore(completion: @escaping (QuerySnapshot?, Error?) -> Void) {
        db.collection(K.FStore.Products.productCollectionName).order(
            by: K.FStore.Products.productName).getDocuments { querySnapshot, error in
            completion(querySnapshot, error)
        }
    }
    
    /// Create array of product objects from the data that we got in API response
    public func createProductsObjArray(with querySnapshot: QuerySnapshot?) -> [Product] {
        var products: [Product] = []
        guard let snapshotDocuments = querySnapshot?.documents else { return products }
        for document in snapshotDocuments {
            let data = document.data()
            guard let name = data[K.FStore.Products.productName] as? String,
                  let id = data[K.FStore.Products.productId] as? String,
                  let image = data[K.FStore.Products.productImage] as? String,
                  let price = data[K.FStore.Products.productPrice] as? String,
                  let category = data[K.FStore.Products.productCategory] as? String,
                  let description = data[K.FStore.Products.productDescription] as? String else { return products }
            products.append(Product(productName: name,
                                    productId: id,
                                    productImageURL: image,
                                    productPrice: price,
                                    productCategory: category,
                                    productDescription: description))
        }
        self.products = products
        return products
    }
    
    //MARK: - UserInfo Section
    
    /// Create new user and add users info to UserInfo collection in firestore
    public func createUser(with email: String?,
                           password: String?,
                           user: UserInfo?,
                           completion: @escaping (AuthDataResult?, Error?) -> Void) {
        guard let email = email, let password = password, let user = user else { return }
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            guard error == nil else {
                completion(authResult, error)
                return
            }
            self.db.collection(K.FStore.User.userInfoCollectionName).addDocument(data: [
                K.FStore.User.firstName: user.firstName,
                K.FStore.User.lastName: user.lastName,
                K.FStore.User.countryName: user.country,
                K.FStore.User.cityName: user.city,
                K.FStore.User.email: user.email
            ])
            completion(authResult, error)
        }
    }
    
    /// Get UserInfo of the currently signed in user from firestore
    public func getUserInfoFromFirestore(completion: @escaping (QuerySnapshot?, Error?) -> Void) {
        guard let email = Auth.auth().currentUser?.email else { return }
        db.collection(K.FStore.User.userInfoCollectionName)
            .whereField(K.FStore.User.email, isEqualTo: email)
            .getDocuments { querySnapshot, error in
                completion(querySnapshot, error)
            }
    }
    
    /// Create UserInfo object from data we got in API response
    public func createUserInfoObj(with querySnapshot: QuerySnapshot?) -> UserInfo? {
        var userInfo: UserInfo?
        guard let snapshotDocuments = querySnapshot?.documents else { return nil }
        for document in snapshotDocuments {
            let data = document.data()
            guard let firstName = data[K.FStore.User.firstName] as? String,
                  let lastName = data[K.FStore.User.lastName] as? String,
                  let country = data[K.FStore.User.countryName] as? String,
                  let city = data[K.FStore.User.cityName] as? String,
                  let email = data[K.FStore.User.email] as? String else { return nil }
            userInfo = UserInfo(firstName: firstName,
                                lastName: lastName,
                                country: country,
                                city: city,
                                email: email)
        }
        return userInfo
    }
    
    //MARK: - Category Section
    
    public func getCategoriesFromFirestore(completion: @escaping (QuerySnapshot?, Error?) -> Void) {
        db.collection(K.FStore.Category.categoryCollectionName).order(
            by: K.FStore.Category.categoryName).getDocuments { querySnapshot, error in
            completion(querySnapshot, error)
        }
    }
    
    public func createCategoryObjArray(with querySnapshot: QuerySnapshot?) -> [Category] {
        var categories: [Category] = []
        guard let snapshotDocuments = querySnapshot?.documents else { return categories }
        for document in snapshotDocuments {
            let data = document.data()
            guard let name = data[K.FStore.Category.categoryName] as? String,
                  let imageURL = data[K.FStore.Category.categoryImage] as? String else { return categories }
            categories.append(Category(categoryName: name,
                                       categoryImageURL: imageURL))
        }
        
        return categories
    }
}

