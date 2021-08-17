//
//  CartTableViewCell.swift
//  Jewllery Store Application
//
//  Created by Stefan Dojcinovic on 14.8.21..
//

import UIKit
import SDWebImage

protocol ReusableTableViewCellDelegate: AnyObject {
    func didTapDelete(at cell: ReusableTableViewCell)
    func didTapStepper(at cell: ReusableTableViewCell)
}

class ReusableTableViewCell: UITableViewCell {
    
    static let identifier = "ReusableTableViewCell"
    
    weak var delegate: ReusableTableViewCellDelegate?
    
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
    
    public let stepperValueLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .white
        label.backgroundColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        label.clipsToBounds = true
        label.textAlignment = .center
        return label
    }()
    
    public let stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.value = 1
        stepper.minimumValue = 1
        stepper.stepValue = 1
        return stepper
    }()
    
    public let deleteProductButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemRed
        button.clipsToBounds = true
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(productImageView)
        contentView.addSubview(productNameLabel)
        contentView.addSubview(productIDLabel)
        contentView.addSubview(productPriceLabel)
        contentView.addSubview(stepper)
        contentView.addSubview(stepperValueLabel)
        contentView.addSubview(deleteProductButton)
        stepper.addTarget(self, action: #selector(didTapStepper), for: .touchUpInside)
        deleteProductButton.addTarget(self, action: #selector(didTapDelete(sender:)), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapStepper(sender: UIStepper) {
        delegate?.didTapStepper(at: self)
        stepperValueLabel.text = Int(stepper.value).description
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
        
        stepper.frame = CGRect(x: contentView.right - 100,
                               y: 5,
                               width: 90,
                               height: 30)
        
        stepperValueLabel.frame = CGRect(x: contentView.right - 75,
                                         y: stepper.bottom + 5,
                                         width: 50,
                                         height: labelHeight)
        
        stepperValueLabel.layer.cornerRadius = 5
        
        deleteProductButton.frame = CGRect(x: contentView.right - 100,
                                           y: stepperValueLabel.bottom + 5,
                                           width: 95,
                                           height: 30)
        
        deleteProductButton.layer.cornerRadius = 5
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productImageView.image = nil
        productIDLabel.text = nil
        productNameLabel.text = nil
        productPriceLabel.text = nil
    }
    
    public func configure(with model: CartReusableTableViewCellViewModel) {
        self.productImageView.sd_setImage(with: URL(string: model.product.productImageURL), completed: nil)
        self.productNameLabel.text = "Name: \(model.product.productName)"
        self.productIDLabel.text = "ID: \(model.product.productId)"
        self.productPriceLabel.text = "Price: \(model.product.productPrice)$"
        self.stepper.value = Double(model.numberOfProducts)
        self.stepperValueLabel.text = model.numberOfProducts.description
    }
    
}
