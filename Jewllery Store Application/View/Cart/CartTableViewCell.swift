//
//  CartTableViewCell.swift
//  Jewllery Store Application
//
//  Created by Stefan Dojcinovic on 14.8.21..
//

import UIKit
import SDWebImage

protocol CartTableViewCellDelegate: AnyObject {
    func didTapDelete(at cell: CartTableViewCell)
}

class CartTableViewCell: UITableViewCell {
    
    static let identifier = "CartTableViewCell"
    
    weak var delegate: CartTableViewCellDelegate?
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        return imageView
    }()
    
    private let productNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        return label
    }()
    
    private let productIDLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        return label
    }()
    
    private let productPriceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        return label
    }()
    
    public let deleteProductButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.tintColor = #colorLiteral(red: 1, green: 0.9929656386, blue: 0.9469751716, alpha: 1)
        button.backgroundColor = .systemRed
        button.clipsToBounds = true
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = #colorLiteral(red: 1, green: 0.9929656386, blue: 0.9469751716, alpha: 1)
        addSubview(productImageView)
        addSubview(productNameLabel)
        addSubview(productIDLabel)
        addSubview(productPriceLabel)
        addSubview(deleteProductButton)
        deleteProductButton.addTarget(self, action: #selector(didTapDelete(sender:)), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapDelete(sender: UIButton) {
        delegate?.didTapDelete(at: self)
        ProductManager.shared.removeProductFromCart(at: sender.tag)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageSize: CGFloat = 100
        let labelWidth: CGFloat = contentView.width - imageSize - 20
        let labelHeight: CGFloat = 30
        let labelXposition: CGFloat = imageSize + 20
        
        productImageView.frame = CGRect(x: 5,
                                        y: 5,
                                        width: imageSize,
                                        height: imageSize)
        
        productImageView.layer.cornerRadius = imageSize / 10
        
        productNameLabel.frame = CGRect(x: labelXposition,
                                        y: 5,
                                        width: labelWidth,
                                        height: labelHeight)
        
        productIDLabel.frame = CGRect(x: labelXposition,
                                      y: productNameLabel.bottom + 5,
                                      width: labelWidth,
                                      height: labelHeight)
        
        productPriceLabel.frame = CGRect(x: labelXposition,
                                         y: productIDLabel.bottom + 5,
                                         width: labelWidth,
                                         height: labelHeight)
        
        deleteProductButton.frame = CGRect(x: contentView.right - 60,
                                           y: 30,
                                           width: 50,
                                           height: 50)
        
        deleteProductButton.layer.cornerRadius = 5
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productImageView.image = nil
        productIDLabel.text = nil
        productNameLabel.text = nil
        productPriceLabel.text = nil
    }
    
    public func configure(with model: Product) {
        self.productImageView.sd_setImage(with: URL(string: model.productImageURL), completed: nil)
        self.productNameLabel.text = "Name: \(model.productName)"
        self.productIDLabel.text = "ID: \(model.productId)"
        self.productPriceLabel.text = "Price: \(model.productPrice)$"
    }
    
}
