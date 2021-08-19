//
//  AboutUsCollectionViewCell.swift
//  Jewllery Store Application
//
//  Created by Stefan Dojcinovic on 18.8.21..
//

import UIKit

class AboutUsCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "AboutUsCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        return imageView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        label.clipsToBounds = true
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.layer.borderWidth = 2
        label.layer.borderColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(imageView)
        contentView.addSubview(descriptionLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: 0,
                                 y: 0,
                                 width: contentView.width,
                                 height: 250)
        
        descriptionLabel.frame = CGRect(x: 10,
                                        y: imageView.bottom + 10,
                                        width: contentView.width - 20,
                                        height: 130)
        
        descriptionLabel.layer.cornerRadius = 10
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        descriptionLabel.text = nil
    }
    
    public func configure(with model: AboutUsCollectionViewCellViewModel?) {
        guard let model = model else { return }
        self.imageView.sd_setImage(with: URL(string: model.imageURL), completed: nil)
        self.descriptionLabel.text = model.description
    }
    
}
