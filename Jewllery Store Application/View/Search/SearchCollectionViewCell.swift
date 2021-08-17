//
//  SearchCollectionViewCell.swift
//  Jewllery Store Application
//
//  Created by Stefan Dojcinovic on 15.8.21..
//

import UIKit
import SDWebImage

class SearchCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SearchCollectionViewCell"
    
    private let categoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let categoryNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        addSubview(categoryImageView)
        addSubview(categoryNameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        categoryImageView.frame = CGRect(x: 2,
                                         y: 2,
                                         width: contentView.width - 4,
                                         height: 170)
        
        categoryImageView.layer.cornerRadius = 15
        
        categoryNameLabel.frame = CGRect(x: 0,
                                         y: contentView.bottom - 30,
                                         width: contentView.width,
                                         height: 30)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        categoryImageView.image = nil
        categoryNameLabel.text = nil
    }
    
    public func configure(with model: Category) {
        self.categoryNameLabel.text = model.categoryName
        self.categoryImageView.sd_setImage(with: URL(string: model.categoryImageURL), completed: nil)
    }
    
    
}
