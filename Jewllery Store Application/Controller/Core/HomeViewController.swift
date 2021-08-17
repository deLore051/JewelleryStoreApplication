//
//  HomeViewController.swift
//  Jewllery Store Application
//
//  Created by Stefan Dojcinovic on 8.8.21..
//

import UIKit

enum BrowseSections: String {
    case onSale = "On Sale"
    case bestSellers = "Best Sellers"
    case recentlyAdded = "Recently Added"
}

class HomeViewController: UIViewController {
    
    private var products: [Product] = []
    private var viewModel: [[Product]]?
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewCompositionalLayout.init(
                sectionProvider: { sectionIndex, _ -> NSCollectionLayoutSection? in
                    return HomeViewController.createSectionLayout(section: sectionIndex)
            }) )
        collectionView.backgroundColor = .systemBackground
        collectionView.register(ProductReusableCollectionViewCell.self,
                                forCellWithReuseIdentifier: ProductReusableCollectionViewCell.identifier)
        collectionView.register(SectionHeaderCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: SectionHeaderCollectionReusableView.identifier)
        return collectionView
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCollectionView()
        self.getProductsFromFirestore()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapSettingsButton))
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = CGRect(x: view.safeAreaInsets.left,
                                      y: view.safeAreaInsets.top,
                                      width: view.width,
                                      height: view.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom)
    }
    
    @objc public func didTapSettingsButton() {
        let vc = SettingsViewController()
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.modalPresentationStyle = .fullScreen
        vc.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    private func getProductsFromFirestore() {
        self.products = []
        APICaller.shared.getProductsFromFirestore { [weak self] querySnapshot, error in
            guard let self = self else { return }
            guard error == nil else {
                self.present(ErrorManager.errorAlert(error!), animated: true, completion: nil)
                return
            }
            self.products = APICaller.shared.createProductsObjArray(with: querySnapshot)
            self.createModel()
            self.collectionView.reloadData()
        }
    }
    
    
    private func createModel() {
        self.viewModel = []
        guard products.count != 0 else { return }
        for _ in 0..<3 {
            var model: [Product] = []
            for _ in 0..<5 {
                model.append(products.randomElement()!)
            }
            self.viewModel?.append(model)
        }
    }
    
}

//MARK: - UICollectionViewDataSource_Delegate

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
        
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let model = viewModel?.count else { return 0 }
        return model
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProductReusableCollectionViewCell.identifier,
            for: indexPath) as! ProductReusableCollectionViewCell
        let model = viewModel![indexPath.section][indexPath.row]
        cell.configure(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: SectionHeaderCollectionReusableView.identifier,
            for: indexPath) as! SectionHeaderCollectionReusableView
        switch indexPath.section {
        case 0:
            header.configure(with: BrowseSections.onSale.rawValue)
        case 1:
            header.configure(with: BrowseSections.bestSellers.rawValue)
        case 2:
            header.configure(with: BrowseSections.recentlyAdded.rawValue)
        default:
            header.configure(with: "-")
        }
        return header
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let model = viewModel?[indexPath.section][indexPath.row] else { return }
        // Open selected product
        let vc = ProductViewController(with: model)
        vc.navigationItem.largeTitleDisplayMode = .always
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private static func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
        return createCellLayoutModel()
    }
    
    private static func createCellLayoutModel() -> NSCollectionLayoutSection {
        // Item
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

        // Group
        let horizontalGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(300)),
            subitem: item,
            count: 1)
        
        let verticalGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.9),
                heightDimension: .absolute(300)),
            subitem: horizontalGroup,
            count: 1)
        
        // Section
        let section = NSCollectionLayoutSection(group: verticalGroup)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(60)),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top)]
        return section
    }
}
