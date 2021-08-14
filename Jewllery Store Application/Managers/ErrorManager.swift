//
//  ErrorManager.swift
//  Jewllery Store Application
//
//  Created by Stefan Dojcinovic on 8.8.21..
//

import Foundation

import UIKit

struct ErrorManager {
    
    static func errorAlert(_ error : Error) -> UIAlertController {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(title: NSLocalizedString(
                            "OK",
                            comment: "Default action"),
                           style: .default,
                           handler: { _ in
        NSLog("The \"OK\" alert occured.")
        }))
        return alert
    }
    
    static func emptyFieldErrorAlert() -> UIAlertController {
        let alert = UIAlertController(title: "Error", message: "All fields must be filled", preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(title: NSLocalizedString(
                            "OK",
                            comment: "Default action"),
                          style: .default,
                          handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        return alert
    }
    
}
