//
//  ProfileViewController.swift
//  Jewllery Store Application
//
//  Created by Stefan Dojcinovic on 8.8.21..
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var userInfo: UserInfo?
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 500)
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9929656386, blue: 0.9469751716, alpha: 1)
        return view
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "person.circle")
        imageView.tintColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.clipsToBounds = true
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        label.layer.borderWidth = 2
        label.layer.borderColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        label.font = .systemFont(ofSize: 22, weight: .regular)
        return label
    }()
    
    private let countryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.clipsToBounds = true
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        label.layer.borderWidth = 2
        label.layer.borderColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        label.font = .systemFont(ofSize: 22, weight: .regular)
        return label
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.clipsToBounds = true
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        label.layer.borderWidth = 2
        label.layer.borderColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        label.font = .systemFont(ofSize: 22, weight: .regular)
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.clipsToBounds = true
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        label.layer.borderWidth = 2
        label.layer.borderColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        label.font = .systemFont(ofSize: 22, weight: .regular)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        addSubviewsToContentView()
        getProfileData()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapSettingsButton))
    }
    
    @objc private func didTapSettingsButton() {
        let navVC = UINavigationController(rootViewController: SettingsViewController())
        navVC.navigationItem.largeTitleDisplayMode = .always
        navVC.modalPresentationStyle = .fullScreen
        navVC.navigationBar.tintColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        self.present(navVC, animated: true, completion: nil)
    }
    
    private func getProfileData() {
        APICaller.shared.getUserInfoFromFireStore { [weak self] querySnapshot, error in
            guard let self = self else { return }
            guard querySnapshot != nil, error == nil else {
                self.present(ErrorManager.errorAlert(error!), animated: true, completion: nil)
                return
            }
            self.userInfo = APICaller.shared.createUserInfoObj(with: querySnapshot)
            self.configureUI()
        }
    }
    
    private func configureUI() {
        guard userInfo != nil, let user = userInfo else { return }
        profileImageView.image = UIImage(named: "test")
        nameLabel.text = "\(user.firstName) \(user.lastName)"
        countryLabel.text = "Country: \(user.country)"
        cityLabel.text = "City: \(user.city)"
        emailLabel.text = "Email: \(user.email)"
    }
    
    private func addSubviewsToContentView() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(countryLabel)
        contentView.addSubview(cityLabel)
        contentView.addSubview(emailLabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = CGRect(x: 0,
                                  y: view.safeAreaInsets.top,
                                  width: view.width,
                                  height: view.height)
        
        contentView.frame = scrollView.bounds
        
        let imageSize: CGFloat = 100
        let imageYposition: CGFloat = contentView.safeAreaInsets.top + 5
        let labelWidth: CGFloat = contentView.width - 20
        let labelHeight: CGFloat = 40
        
        profileImageView.frame = CGRect(x: 5,
                                        y: contentView.safeAreaInsets.top + 5,
                                        width: imageSize,
                                        height: imageSize)
        
        profileImageView.layer.cornerRadius = imageSize / 2
        
        nameLabel.frame = CGRect(x: profileImageView.right + 10,
                                 y: imageYposition + 30,
                                 width: contentView.width - 25 - imageSize,
                                 height: labelHeight)
        
        nameLabel.layer.cornerRadius = labelHeight / 2
        
        countryLabel.frame = CGRect(x: 10,
                                    y: profileImageView.bottom + 10,
                                    width: labelWidth,
                                    height: labelHeight)
        
        countryLabel.layer.cornerRadius = labelHeight / 2
        
        cityLabel.frame = CGRect(x: 10,
                                 y: countryLabel.bottom + 10,
                                 width: labelWidth,
                                 height: labelHeight)
        
        cityLabel.layer.cornerRadius = labelHeight / 2
        
        emailLabel.frame = CGRect(x: 10,
                                  y: cityLabel.bottom + 10,
                                  width: labelWidth,
                                  height: labelHeight)
        
        emailLabel.layer.cornerRadius = labelHeight / 2
    }

}
