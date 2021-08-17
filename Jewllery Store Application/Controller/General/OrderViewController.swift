//
//  OrderViewController.swift
//  Jewllery Store Application
//
//  Created by Stefan Dojcinovic on 8.8.21..
//

import UIKit

class OrderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapSettingsButton))
    }
    
    @objc public func didTapSettingsButton() {
        let vc = SettingsViewController()
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.modalPresentationStyle = .fullScreen
        vc.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        navigationController?.pushViewController(vc, animated: true)
    }

}
