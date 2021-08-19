//
//  SectionHeaderCollectionReusableView.swift
//  Jewllery Store Application
//
//  Created by Stefan Dojcinovic on 9.8.21..
//

import UIKit

class SectionHeaderCollectionReusableView: UICollectionReusableView {
        
    static let identifier = "SectionHeaderCollectionReusableView"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        let customFont = UIFont(name: "Satisfy", size: 30)
        label.font = customFont
        label.textColor = #colorLiteral(red: 1, green: 0.9929656386, blue: 0.9469751716, alpha: 1)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
//        backgroundColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = CGRect(x: 30,
                                  y: 0,
                                  width: width - 60,
                                  height: height)
    }
    
    func configure(with title: String) {
        self.titleLabel.text = title
    }
}
