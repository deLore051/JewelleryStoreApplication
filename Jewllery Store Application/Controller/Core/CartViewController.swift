//
//  CartViewController.swift
//  Jewllery Store Application
//
//  Created by Stefan Dojcinovic on 8.8.21..
//

import UIKit

class CartViewController: UIViewController {
    
    private var productsInCart: [Product] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .systemBackground
        tableView.register(CartTableViewCell.self, forCellReuseIdentifier: CartTableViewCell.identifier)
        tableView.layer.borderWidth = 2
        tableView.layer.borderColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        tableView.clipsToBounds = true
        return tableView
    }()
    
    private let totalLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        label.clipsToBounds = true
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    private let clearButton: UIButton = {
        let button = UIButton()
        button.setTitle("Clear", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .semibold)
        button.backgroundColor = .systemRed
        button.clipsToBounds = true
        return button
    }()
    
    private let orderButton: UIButton = {
        let button = UIButton()
        button.setTitle("Order", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .semibold)
        button.backgroundColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        button.clipsToBounds = true
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        getProducts()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.addSubview(totalLabel)
        view.addSubview(clearButton)
        view.addSubview(orderButton)
        
        clearButton.addTarget(self, action: #selector(didTapClearButton), for: .touchUpInside)
        orderButton.addTarget(self, action: #selector(didTapOrderButton), for: .touchUpInside)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc private func didTapClearButton() {
        ProductManager.shared.clearCartTable()
        self.productsInCart = []
        tableView.reloadData()
    }
    
    @objc private func didTapOrderButton() {
        let vc = OrderViewController()
        vc.title = "Order"
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let buttonWidth: CGFloat = (view.width / 2) - 30
        let buttonHeight: CGFloat = 40
        
        tableView.frame = CGRect(x: 5,
                                 y: view.safeAreaInsets.top + 5,
                                 width: view.width - 10,
                                 height: 400)
        
        tableView.layer.cornerRadius = 10
        
        totalLabel.frame = CGRect(x: 5,
                                  y: tableView.bottom + 5,
                                  width: view.width - 10,
                                  height: 30)
        
        totalLabel.layer.cornerRadius = 15
        
        clearButton.frame = CGRect(x: 20,
                                   y: totalLabel.bottom + 20,
                                   width: buttonWidth,
                                   height: buttonHeight)
        
        clearButton.layer.cornerRadius = buttonHeight / 2
        
        orderButton.frame = CGRect(x: buttonWidth + 40,
                                   y: totalLabel.bottom + 20,
                                   width: buttonWidth,
                                   height: buttonHeight)
        
        orderButton.layer.cornerRadius = buttonHeight / 2
    }
    
    private func getProducts() {
        self.productsInCart = ProductManager.shared.getProductsInCart()
        self.totalLabel.text = "   Total: \(ProductManager.shared.calculateTotal())$"
        tableView.reloadData()
    }

}

//MARK: - UITableViewDataSource_Delegate

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfProducts = productsInCart.count
        guard numberOfProducts != 0 else { return 0 }
        return numberOfProducts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.identifier,
                                                 for: indexPath) as! CartTableViewCell
        cell.deleteProductButton.tag = indexPath.row
        let model = productsInCart[indexPath.row]
        cell.configure(with: model)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = productsInCart[indexPath.row]
        let vc = ProductViewController(with: model)
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension CartViewController: CartTableViewCellDelegate {
    func didTapDelete(at cell: CartTableViewCell) {
        DispatchQueue.main.async {
            self.getProducts()
        }
    }
}
