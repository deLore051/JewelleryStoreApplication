//
//  SearchViewController.swift
//  Jewllery Store Application
//
//  Created by Stefan Dojcinovic on 8.8.21..
//

import UIKit

class SearchViewController: UIViewController {
    
    // This is a test array, you should get these values from firestore because later admin might add more categories
    private var categories: [Category] = []
    
    private let searchController: UISearchController = {
        let searchVC = UISearchController(searchResultsController: SearchResultsViewController())
        searchVC.searchBar.placeholder = "Product name..."
        searchVC.searchBar.searchBarStyle = .minimal
        searchVC.definesPresentationContext = true
        return searchVC
    }()
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewCompositionalLayout(
                sectionProvider: { sectionIndex, _ -> NSCollectionLayoutSection? in
                    return SearchViewController.createSectionLayout(section: sectionIndex)
            }))
        collectionView.backgroundColor = .systemBackground
        collectionView.register(
            SearchCollectionViewCell.self,
            forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        getCategories()
        view.backgroundColor = .systemBackground
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapSettingsButton))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    @objc public func didTapSettingsButton() {
        let vc = SettingsViewController()
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.modalPresentationStyle = .fullScreen
        vc.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        navigationController?.pushViewController(vc, animated: true)
    }

    private func getCategories() {
        APICaller.shared.getCategoriesFromFirestore { [weak self] querySnapshot, error in
            guard let self = self else { return }
            guard error == nil else {
                self.present(ErrorManager.errorAlert(error!), animated: true, completion: nil)
                return
            }
            self.categories = APICaller.shared.createCategoryObjArray(with: querySnapshot)
            self.collectionView.reloadData()
        }
    }
}

//MARK: - UICollectionViewDataSource_Delegate

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfItems = categories.count
        guard numberOfItems != 0 else { return 0 }
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SearchCollectionViewCell.identifier,
            for: indexPath) as! SearchCollectionViewCell
        cell.configure(with: categories[indexPath.row])
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 15
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let category = categories[indexPath.row].categoryName
        let vc = CategoryViewController(with: category)
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.title = category
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private static func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.4),
                heightDimension: .absolute(200)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let horizontalGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(200)),
            subitem: item,
            count: 2)
        
        let verticalGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(200)),
            subitem: horizontalGroup,
            count: 1)
        
        let section = NSCollectionLayoutSection(group: verticalGroup)
        return section
    }
}

//MARK: - UISearchResultsUpdating_Delegate

extension SearchViewController: UISearchBarDelegate, UISearchResultsUpdating {
        
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let resultsController = searchController.searchResultsController as? SearchResultsViewController,
              let query = searchController.searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        let model = ProductManager.shared.search(with: query)
        DispatchQueue.main.async {
            let vc = resultsController
            vc.navigationItem.largeTitleDisplayMode = .never
            vc.modalPresentationStyle = .fullScreen
            vc.configure(with: model)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
    }
}
