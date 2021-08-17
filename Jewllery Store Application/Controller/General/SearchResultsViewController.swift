//
//  SearchResultsViewController.swift
//  Jewllery Store Application
//
//  Created by Stefan Dojcinovic on 17.8.21..
//

import UIKit

class SearchResultsViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(
            ReusableTableViewCell.self,
            forCellReuseIdentifier: ReusableTableViewCell.identifier)
        tableView.isHidden = true
        return tableView
    }()
    
    private var searchResults: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapSettingsButton))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    @objc public func didTapSettingsButton() {
        let vc = SettingsViewController()
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.modalPresentationStyle = .fullScreen
        vc.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    public func configure(with model: [Product]) {
        self.searchResults = model
        tableView.isHidden = false
        tableView.reloadData()
    }

}

//MARK: - UITableViewDataSource_Delegate

extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard searchResults.count != 0 else { return 0 }
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReusableTableViewCell.identifier,
                                                 for: indexPath) as! ReusableTableViewCell
        let model = searchResults[indexPath.row]
        cell.configure(with: CartReusableTableViewCellViewModel(product: model, numberOfProducts: 1))
        cell.deleteProductButton.isHidden = true
        cell.stepper.isHidden = true
        cell.stepperValueLabel.isHidden = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = ProductViewController(with: searchResults[indexPath.row])
        vc.modalPresentationStyle = .fullScreen
        vc.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
