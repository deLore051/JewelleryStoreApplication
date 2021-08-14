//
//  SignUpViewController.swift
//  Jewllery Store Application
//
//  Created by Stefan Dojcinovic on 9.8.21..
//

import UIKit

class SignUpViewController: UIViewController {
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9929656386, blue: 0.9469751716, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 750)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let firstNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "First Name:"
        label.textColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    private let lastNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Last Name:"
        label.textColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    private let countryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Country:"
        label.textColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "City:"
        label.textColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Email:"
        label.textColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()

    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Password:"
        label.textColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()

    private let firsNameTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 18, weight: .regular)
        textField.layer.borderWidth = 2
        textField.layer.borderColor = #colorLiteral(red: 0.8225557022, green: 0.7167796632, blue: 0.006349424953, alpha: 1)
        textField.clipsToBounds = true
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.backgroundColor = .secondarySystemBackground
        return textField
    }()
    
    private let lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 18, weight: .regular)
        textField.layer.borderWidth = 2
        textField.layer.borderColor = #colorLiteral(red: 0.8225557022, green: 0.7167796632, blue: 0.006349424953, alpha: 1)
        textField.clipsToBounds = true
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.backgroundColor = .secondarySystemBackground
        return textField
    }()
    
    private let countryTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 18, weight: .regular)
        textField.layer.borderWidth = 2
        textField.layer.borderColor = #colorLiteral(red: 0.8225557022, green: 0.7167796632, blue: 0.006349424953, alpha: 1)
        textField.clipsToBounds = true
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.backgroundColor = .secondarySystemBackground
        return textField
    }()
    
    private let cityTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 18, weight: .regular)
        textField.layer.borderWidth = 2
        textField.layer.borderColor = #colorLiteral(red: 0.8225557022, green: 0.7167796632, blue: 0.006349424953, alpha: 1)
        textField.clipsToBounds = true
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.backgroundColor = .secondarySystemBackground
        return textField
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 18, weight: .regular)
        textField.layer.borderWidth = 2
        textField.layer.borderColor = #colorLiteral(red: 0.8225557022, green: 0.7167796632, blue: 0.006349424953, alpha: 1)
        textField.clipsToBounds = true
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.backgroundColor = .secondarySystemBackground
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 18, weight: .regular)
        textField.layer.borderWidth = 2
        textField.layer.borderColor = #colorLiteral(red: 0.8225557022, green: 0.7167796632, blue: 0.006349424953, alpha: 1)
        textField.clipsToBounds = true
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.backgroundColor = .secondarySystemBackground
        return textField
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 26, weight: .semibold)
        button.setTitleColor(#colorLiteral(red: 1, green: 0.9929656386, blue: 0.9469751716, alpha: 1), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        button.clipsToBounds = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        addSubviewToContentView()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back",
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(didTapBackButton))
        registerButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
    }
    
    private func addSubviewToContentView() {
        contentView.addSubview(firstNameLabel)
        contentView.addSubview(lastNameLabel)
        contentView.addSubview(countryLabel)
        contentView.addSubview(cityLabel)
        contentView.addSubview(emailLabel)
        contentView.addSubview(passwordLabel)
        contentView.addSubview(firsNameTextField)
        contentView.addSubview(lastNameTextField)
        contentView.addSubview(countryTextField)
        contentView.addSubview(cityTextField)
        contentView.addSubview(emailTextField)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(registerButton)
    }
    
    private func addSubviewToScrollView() {
        scrollView.addSubview(firstNameLabel)
        scrollView.addSubview(lastNameLabel)
        scrollView.addSubview(countryLabel)
        scrollView.addSubview(cityLabel)
        scrollView.addSubview(emailLabel)
        scrollView.addSubview(passwordLabel)
        scrollView.addSubview(firsNameTextField)
        scrollView.addSubview(lastNameTextField)
        scrollView.addSubview(countryTextField)
        scrollView.addSubview(cityTextField)
        scrollView.addSubview(emailTextField)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(registerButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = CGRect(x: 0,
                                  y: view.safeAreaInsets.top,
                                  width: view.width,
                                  height: view.height)
    
        contentView.frame = scrollView.bounds
        
        let labelWidth: CGFloat = contentView.width - 10
        let labelHeight: CGFloat = 30
        let textFieldWidth: CGFloat = contentView.width - 20
        let textFieldHeight: CGFloat = 40
        let buttonWidth: CGFloat = contentView.width - 40
        let buttonHeight: CGFloat = 60
        
        firstNameLabel.frame = CGRect(x: 5,
                                      y: contentView.safeAreaInsets.top + 20,
                                      width: labelWidth,
                                      height: labelHeight)
        
        firsNameTextField.frame = CGRect(x: 10,
                                         y: firstNameLabel.bottom + 5,
                                         width: textFieldWidth,
                                         height: textFieldHeight)
        
        firsNameTextField.layer.cornerRadius = textFieldHeight / 2
        
        lastNameLabel.frame = CGRect(x: 5,
                                     y: firsNameTextField.bottom + 10,
                                     width: labelWidth,
                                     height: labelHeight)
        
        lastNameTextField.frame = CGRect(x: 10,
                                         y: lastNameLabel.bottom + 5,
                                         width: textFieldWidth,
                                         height: textFieldHeight)
        
        lastNameTextField.layer.cornerRadius = textFieldHeight / 2
        
        countryLabel.frame = CGRect(x: 5,
                                    y: lastNameTextField.bottom + 10,
                                    width: labelWidth,
                                    height: labelHeight)
        
        countryTextField.frame = CGRect(x: 10,
                                        y: countryLabel.bottom + 5,
                                        width: textFieldWidth,
                                        height: textFieldHeight)
        
        countryTextField.layer.cornerRadius = textFieldHeight / 2
        
        cityLabel.frame = CGRect(x: 5,
                                 y: countryTextField.bottom + 10,
                                 width: labelWidth,
                                 height: labelHeight)
        
        cityTextField.frame = CGRect(x: 10,
                                     y: cityLabel.bottom + 5,
                                     width: textFieldWidth,
                                     height: textFieldHeight)
        
        cityTextField.layer.cornerRadius = textFieldHeight / 2
        
        emailLabel.frame = CGRect(x: 5,
                                  y: cityTextField.bottom + 10,
                                  width: labelWidth,
                                  height: labelHeight)
        
        emailTextField.frame = CGRect(x: 10,
                                      y: emailLabel.bottom + 5,
                                      width: textFieldWidth,
                                      height: textFieldHeight)
        
        emailTextField.layer.cornerRadius = textFieldHeight / 2
        
        passwordLabel.frame = CGRect(x: 5,
                                     y: emailTextField.bottom + 10,
                                     width: labelWidth,
                                     height: labelHeight)
        
        passwordTextField.frame = CGRect(x: 10,
                                         y: passwordLabel.bottom + 5,
                                         width: textFieldWidth,
                                         height: textFieldHeight)
        
        passwordTextField.layer.cornerRadius = textFieldHeight / 2
        
        registerButton.frame = CGRect(x: 20,
                                      y: passwordTextField.bottom + 40,
                                      width: buttonWidth,
                                      height: buttonHeight)
        
        registerButton.layer.cornerRadius = buttonHeight / 2
    }
    
    @objc private func didTapRegisterButton() {
        registerButton.changeAlphaWhenTapped(sender: registerButton)
        let userInfo = createUserInfoObject()
        guard userInfo != nil else { return }
        APICaller.shared.createUser(with: emailTextField.text,
                                    password: passwordTextField.text,
                                    user: userInfo) { [weak self] _, error in
            guard let self = self else { return }
            guard error == nil else {
                self.present(ErrorManager.errorAlert(error!), animated: true, completion: nil)
                return
            }
            DispatchQueue.main.async {
                let navVC = UINavigationController(rootViewController: TabBarViewController())
                navVC.modalPresentationStyle = .fullScreen
                navVC.navigationBar.isHidden = true
                self.present(navVC, animated: true, completion: nil)
            }
        }
    }
    
    private func createUserInfoObject() -> UserInfo? {
        guard let firstName = firsNameTextField.text, !firstName.replacingOccurrences(of: " ", with: "").isEmpty,
              let lastName = lastNameTextField.text, !lastName.replacingOccurrences(of: " ", with: "").isEmpty,
              let country = countryTextField.text, !country.replacingOccurrences(of: " ", with: "").isEmpty,
              let city = cityTextField.text, !city.replacingOccurrences(of: " ", with: "").isEmpty,
              let email = emailTextField.text, !email.replacingOccurrences(of: " ", with: "").isEmpty else {
            
            self.present(ErrorManager.emptyFieldErrorAlert(), animated: true, completion: nil)
            return nil
        }
        
        return UserInfo(firstName: firstName,
                        lastName: lastName,
                        country: country,
                        city: city,
                        email: email)
    }
    
    @objc private func didTapBackButton() {
        dismiss(animated: true, completion: nil)
        //self.navigationController?.popToViewController(SignInViewController(), animated: true)
    }
    
    
}
