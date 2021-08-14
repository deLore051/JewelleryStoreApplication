//
//  ForTesting.swift
//  Jewllery Store Application
//
//  Created by Stefan Dojcinovic on 12.8.21..
//

import UIKit

final class DefaultValues {
    
    static let shared = DefaultValues()
    
    private init() { }
    
    static let defaultUserInfo = UserInfo(firstName: "-",
                                       lastName: "-",
                                       country: "-",
                                       city: "-",
                                       email: "-")
    
    
}
