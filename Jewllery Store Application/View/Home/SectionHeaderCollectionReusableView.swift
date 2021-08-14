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
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 26, weight: .semibold)
        label.textColor = #colorLiteral(red: 1, green: 0.9929656386, blue: 0.9469751716, alpha: 1)
        label.backgroundColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = bounds
    }
    
    func configure(with title: String) {
        self.titleLabel.text = title
    }
}
