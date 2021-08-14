//
//  AuthManager.swift
//  Jewllery Store Application
//
//  Created by Stefan Dojcinovic on 8.8.21..
//

import UIKit
import Firebase

enum APIError: Error {
    case failedToGetData
    case failedToCreateUserInfoDocument
}

final class AuthManager {
    
    static let shared = AuthManager()
    
    private init() { }
    
    public func signIn(with email: String?, password: String?, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let email = email, let password = password, !email.isEmpty, !password.isEmpty else {
            completion(.failure(APIError.failedToGetData))
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { autResult, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            completion(.success(true))
        }
    }
    
    public func signUp(with email: String?, password: String?, userInfo: UserInfo, completion: @escaping (Bool) -> Void) {
        guard let email = email, let password = password, !email.isEmpty, !password.isEmpty else {
            completion(false)
            return
        }
        completion(true)
    }
    
    public func presentTabBarViewController(with viewController: UIViewController) {
        let vc = TabBarViewController()
        vc.modalPresentationStyle = .fullScreen
        let navVC = UINavigationController(rootViewController: vc)
        viewController.present(navVC, animated: true, completion: nil)
    }
    
    /// Attempt to log out firebase user
    public func logOut(comletion: (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            comletion(true)
            return
        } catch {
            print(error)
            comletion(false)
            return
        }
    }
    
}
