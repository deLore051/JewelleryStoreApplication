//
//  ProductReusableCollectionViewCell.swift
//  Jewllery Store Application
//
//  Created by Stefan Dojcinovic on 10.8.21..
//

import UIKit
import SDWebImage


final class ProductReusableCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ProductReusableCollectionViewCell"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .center
        label.backgroundColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
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
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(nameLabel)
        addSubview(productImageView)
        addSubview(priceLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let labelWidth: CGFloat = contentView.width - 10
        let labelHeight: CGFloat = 30
        let imageWidth: CGFloat = contentView.width - 10
        let imageHeight: CGFloat = 200
        
        nameLabel.frame = CGRect(x: 5,
                                 y: 5,
                                 width: labelWidth,
                                 height: labelHeight)
        
        nameLabel.layer.cornerRadius = labelHeight / 2
        
        productImageView.frame = CGRect(x: 5,
                                        y: nameLabel.bottom + 5,
                                        width: imageWidth,
                                        height: imageHeight)
        
        productImageView.layer.cornerRadius = 10
        
        priceLabel.frame = CGRect(x: 5,
                                  y: productImageView.bottom + 5,
                                  width: labelWidth,
                                  height: labelHeight)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        productImageView.image = nil
        priceLabel.text = nil
    }
    
    public func configure(with model: Product?) {
        guard let product = model else { return }
        self.nameLabel.text = product.productName
        self.productImageView.sd_setImage(with: URL(string: product.productImageURL), completed: nil)
        self.priceLabel.text = "Price: \(product.productPrice)$"
    }
    
}
