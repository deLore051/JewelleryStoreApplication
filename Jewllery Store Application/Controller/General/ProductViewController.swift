//
//  ProductViewController.swift
//  Jewllery Store Application
//
//  Created by Stefan Dojcinovic on 8.8.21..
//

import UIKit

class ProductViewController: UIViewController {
    
    private var product: Product?
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 750)
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()

    private let productNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.backgroundColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        label.textAlignment = .center
        label.textColor = .white
        label.clipsToBounds = true
        return label
    }()
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        imageView.backgroundColor = .white
        return imageView
    }()
    
    private let productIdLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.backgroundColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        label.textColor = .white
        label.clipsToBounds = true
        return label
    }()
    
    private let productPriceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.backgroundColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        label.textColor = .white
        label.clipsToBounds = true
        return label
    }()
    
    private let productDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.backgroundColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        label.textColor = .white
        label.clipsToBounds = true
        return label
    }()
    
    private let addToCartButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add to Cart", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 26, weight: .semibold)
        button.titleLabel?.textColor = .white
        button.backgroundColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        button.clipsToBounds = true
        return button
    }()
    
    init(with product: Product) {
        super.init(nibName: nil, bundle: nil)
        configure(with: product)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        addSubviewToContentView()
        addToCartButton.addTarget(self, action: #selector(didTapAddToCart), for: .touchUpInside)
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
    
    private func addSubviewToContentView() {
        contentView.addSubview(productNameLabel)
        contentView.addSubview(productImageView)
        contentView.addSubview(productIdLabel)
        contentView.addSubview(productPriceLabel)
        contentView.addSubview(productDescriptionLabel)
        contentView.addSubview(addToCartButton)
    }
    
    @objc private func didTapAddToCart() {
        addToCartButton.changeAlphaWhenTapped(sender: addToCartButton)
        guard product != nil, let product = product else { return }
        ProductManager.shared.addProductToCart(model: product)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = CGRect(x: 0,
                                  y: view.safeAreaInsets.top,
                                  width: view.width,
                                  height: view.height)
        
        contentView.frame = scrollView.bounds
        
        let labelWidth: CGFloat = view.width - 10
        let labelHeight: CGFloat = 40
        let imageSize: CGFloat = view.width - 20
        let buttonWidth: CGFloat = view.width - 20
        let buttonHeight: CGFloat = 50
        
        productNameLabel.frame = CGRect(x: 5,
                                        y: contentView.safeAreaInsets.top + 10,
                                        width: labelWidth,
                                        height: labelHeight)
        
        productNameLabel.layer.cornerRadius = labelHeight / 2
        
        productImageView.frame = CGRect(x: 10,
                                        y: productNameLabel.bottom + 5,
                                        width: imageSize,
                                        height: 300)
        
        productImageView.layer.cornerRadius = imageSize / 10
        
        productIdLabel.frame = CGRect(x: 5,
                                      y: productImageView.bottom + 5,
                                      width: labelWidth,
                                      height: labelHeight)
        
        productIdLabel.layer.cornerRadius = labelHeight / 2
        
        productPriceLabel.frame = CGRect(x: 5,
                                    y: productIdLabel.bottom + 5,
                                    width: labelWidth,
                                    height: labelHeight)
        
        productPriceLabel.layer.cornerRadius = labelHeight / 2
        
        productDescriptionLabel.frame = CGRect(x: 5,
                                          y: productPriceLabel.bottom + 5,
                                          width: labelWidth,
                                          height: 120)
        
        productDescriptionLabel.layer.cornerRadius = labelHeight / 2
        
        addToCartButton.frame = CGRect(x: 10,
                                       y: productDescriptionLabel.bottom + 30,
                                       width: buttonWidth,
                                       height: buttonHeight)
        
        addToCartButton.layer.cornerRadius = buttonHeight / 2
        
    }
    
    private func configure(with model: Product) {
        self.product = model
        self.productNameLabel.text = model.productName
        self.productImageView.sd_setImage(with: URL(string: model.productImageURL), completed: nil)
        self.productIdLabel.text = "   ProductID: \(model.productId)"
        self.productPriceLabel.text = "   Price: \(model.productPrice)$"
        self.productDescriptionLabel.text = "   Description: \(model.productDescription)"
    }

}
