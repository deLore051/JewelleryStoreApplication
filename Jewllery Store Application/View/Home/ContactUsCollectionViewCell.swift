//
//  ContactUsCollectionViewCell.swift
//  Jewllery Store Application
//
//  Created by Stefan Dojcinovic on 18.8.21..
//

import UIKit

class ContactUsCollectionViewCell: UICollectionViewCell {
 
    static let identifier = "ContactUsCollectionViewCell"
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        label.font = .systemFont(ofSize: 22, weight: .regular)
        return label
    }()
    
    private let mobileLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        label.font = .systemFont(ofSize: 22, weight: .regular)
        return label
    }()
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        label.font = .systemFont(ofSize: 22, weight: .regular)
        return label
    }()
    
    private let address1Label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        label.font = .systemFont(ofSize: 22, weight: .regular)
        return label
    }()
    
    private let address2Label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        label.font = .systemFont(ofSize: 22, weight: .regular)
        return label
    }()
    
    private let madeByLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Made by: stefan.dojcinovic051@gmail.com"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .darkGray
        contentView.addSubview(emailLabel)
        contentView.addSubview(mobileLabel)
        contentView.addSubview(phoneLabel)
        contentView.addSubview(address1Label)
        contentView.addSubview(address2Label)
        contentView.addSubview(madeByLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let labelWidth: CGFloat = contentView.width - 20
        let labelHeight: CGFloat = 30
        
        emailLabel.frame = CGRect(x: 10,
                                  y: 10,
                                  width: labelWidth,
                                  height: labelHeight)
        
        mobileLabel.frame = CGRect(x: 10,
                                   y: emailLabel.bottom + 10,
                                   width: labelWidth,
                                   height: labelHeight)
        
        phoneLabel.frame = CGRect(x: 10,
                                  y: mobileLabel.bottom + 10,
                                  width: labelWidth,
                                  height: labelHeight)
        
        address1Label.frame = CGRect(x: 10,
                                     y: phoneLabel.bottom + 10,
                                     width: labelWidth,
                                     height: labelHeight)
        
        address2Label.frame = CGRect(x: 10,
                                     y: address1Label.bottom + 10,
                                     width: labelWidth,
                                     height: labelHeight)
        
        madeByLabel.frame = CGRect(x: 10,
                                   y: contentView.bottom - 30,
                                   width: labelWidth,
                                   height: labelHeight)
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.emailLabel.text = nil
        self.mobileLabel.text = nil
        self.phoneLabel.text = nil
        self.address1Label.text = nil
        self.address2Label.text = nil
    }

    public func configure(with model: ContactUsCollectionViewCellViewModel?) {
        guard let model = model else { return }
        self.emailLabel.text = "Email: \(model.email)"
        self.mobileLabel.text = "Mobile: \(model.mobilePhone)"
        self.phoneLabel.text = "Phone: \(model.phone)"
        self.address1Label.text = "Address1: \(model.address1)"
        self.address2Label.text = "Address2: \(model.address2)"
    }
    
}
