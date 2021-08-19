//
//  HomeViewController.swift
//  Jewllery Store Application
//
//  Created by Stefan Dojcinovic on 8.8.21..
//

import UIKit

enum BrowseSections: String {
    case aboutUs = "About Us"
    case onSale = "On Sale"
    case bestSellers = "Best Sellers"
    case recentlyAdded = "Recently Added"
    case contacts = "Contact Us"
}

class HomeViewController: UIViewController {
    
    private var products: [Product] = []
    private var viewModel: [[Product]]?
    private var aboutUs: AboutUsCollectionViewCellViewModel?
    private var contactUs: ContactUsCollectionViewCellViewModel?
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewCompositionalLayout.init(
                sectionProvider: { sectionIndex, _ -> NSCollectionLayoutSection? in
                    return HomeViewController.getLayoutSection(section: sectionIndex)
            }) )
        collectionView.backgroundColor = .systemBackground
        collectionView.register(ProductReusableCollectionViewCell.self,
                                forCellWithReuseIdentifier: ProductReusableCollectionViewCell.identifier)
        collectionView.register(AboutUsCollectionViewCell.self,
                                forCellWithReuseIdentifier: AboutUsCollectionViewCell.identifier)
        collectionView.register(ContactUsCollectionViewCell.self,
                                forCellWithReuseIdentifier: ContactUsCollectionViewCell.identifier)
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
        self.getData()
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
    
    private static func getLayoutSection(section: Int) -> NSCollectionLayoutSection {
        return HomeSectionLayoutManager.createSectionLayout(section: section)
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
    
    private func getData() {
        getProductsFromFirestore()
        getAboutUsDataFromFirestore()
        getContactUsDataFormFirestore()
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
    
    private func getAboutUsDataFromFirestore() {
        APICaller.shared.getAboutUsDataFromFirestore { [weak self] querySnapshot, error in
            guard let self = self else { return }
            guard error == nil else {
                self.present(ErrorManager.errorAlert(error!), animated: true, completion: nil)
                return
            }
            self.aboutUs = APICaller.shared.createAboutUsObj(with: querySnapshot)
            self.collectionView.reloadData()
        }
    }
    
    private func getContactUsDataFormFirestore() {
        APICaller.shared.getConactDataFromFirestore { [weak self] querySnapshot, error in
            guard let self = self else { return }
            guard error == nil else {
                self.present(ErrorManager.errorAlert(error!), animated: true, completion: nil)
                return
            }
            self.contactUs = APICaller.shared.createContactUsObj(with: querySnapshot)
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
        guard (viewModel?.count) != nil else { return 0 }
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 5
        case 2:
            return 5
        case 3:
            return 5
        case 4:
            return 1
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: AboutUsCollectionViewCell.identifier,
                for: indexPath) as! AboutUsCollectionViewCell
            cell.configure(with: aboutUs)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductReusableCollectionViewCell.identifier,
                for: indexPath) as! ProductReusableCollectionViewCell
            let model = viewModel![indexPath.section - 1][indexPath.row]
            cell.configure(with: model)
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductReusableCollectionViewCell.identifier,
                for: indexPath) as! ProductReusableCollectionViewCell
            let model = viewModel![indexPath.section - 1][indexPath.row]
            cell.configure(with: model)
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductReusableCollectionViewCell.identifier,
                for: indexPath) as! ProductReusableCollectionViewCell
            let model = viewModel![indexPath.section - 1][indexPath.row]
            cell.configure(with: model)
            return cell
        case 4:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ContactUsCollectionViewCell.identifier,
                for: indexPath) as! ContactUsCollectionViewCell
            cell.configure(with: contactUs)
            return cell
        default:
            return UICollectionViewCell()
        }
        
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
            header.configure(with: BrowseSections.aboutUs.rawValue)
        case 1:
            header.configure(with: BrowseSections.onSale.rawValue)
        case 2:
            header.configure(with: BrowseSections.bestSellers.rawValue)
        case 3:
            header.configure(with: BrowseSections.recentlyAdded.rawValue)
        case 4:
            header.configure(with: BrowseSections.contacts.rawValue)
        default:
            header.configure(with: "-")
        }
        return header
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let section = indexPath.section
        if section == 1 || section == 2 || section == 3 {
            guard let model = viewModel?[section - 1][indexPath.row] else { return }
            let vc = ProductViewController(with: model)
            vc.navigationItem.largeTitleDisplayMode = .always
            vc.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}
