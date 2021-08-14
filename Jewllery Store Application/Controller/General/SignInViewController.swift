//
//  ViewController.swift
//  Jewllery Store Application
//
//  Created by Stefan Dojcinovic on 8.8.21..
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let emailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.numberOfLines = 1
        label.text = "Email:"
        label.textColor = #colorLiteral(red: 0.8225557022, green: 0.7167796632, blue: 0.006349424953, alpha: 1)
        return label
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.numberOfLines = 1
        label.text = "Password:"
        label.textColor = #colorLiteral(red: 0.8225557022, green: 0.7167796632, blue: 0.006349424953, alpha: 1)
        return label
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "example@gmail.com"
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
        textField.isSecureTextEntry = true
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
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 28, weight: .medium)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        button.clipsToBounds = true
        return button
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Dont have an account?. Sign up here", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        button.clipsToBounds = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9929656386, blue: 0.9469751716, alpha: 1)
        view.addSubview(logoImageView)
        view.addSubview(emailLabel)
        view.addSubview(passwordLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
        view.addSubview(signUpButton)
        
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
    
    }
    
    @objc private func didTapSignIn() {
        AuthManager.shared.signIn(with: emailTextField.text, password: passwordTextField.text) { [weak self] result in
            guard let self = self else { return }
            self.signInButton.changeAlphaWhenTapped(sender: self.signInButton)
            switch result {
            case .success:
                DispatchQueue.main.async {
                    let vc = TabBarViewController()
                    vc.modalPresentationStyle = .fullScreen
                    vc.navigationController?.navigationBar.isHidden = true
                    self.navigationController!.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                self.present(ErrorManager.errorAlert(error), animated: true, completion: nil)
            }
        }
    }
    
    @objc private func didTapSignUp() {
        signUpButton.changeAlphaWhenTapped(sender: signUpButton)
        let navVC = UINavigationController(rootViewController: SignUpViewController())
        navVC.navigationBar.tintColor = #colorLiteral(red: 0.8504856825, green: 0.7429254651, blue: 0, alpha: 1)
        navVC.modalPresentationStyle = .fullScreen
        self.present(navVC, animated: true, completion: nil)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let labelWidth: CGFloat = view.width - 20
        let labelHeight: CGFloat = 30
        let textFieldWidth: CGFloat = view.width - 30
        let textFieldHeight: CGFloat = 40
        let buttonWidth: CGFloat = view.width - 40
        let buttonHeight: CGFloat = 60
        
        logoImageView.frame = CGRect(x: 10,
                                     y: view.safeAreaInsets.top + 10,
                                     width: view.width - 20,
                                     height: 200)
        
        emailLabel.frame = CGRect(x: 10,
                                  y: logoImageView.bottom ,
                                  width:  labelWidth,
                                  height: labelHeight)
        
        emailTextField.frame = CGRect(x: 15,
                                      y: emailLabel.bottom + 10,
                                      width: textFieldWidth,
                                      height: textFieldHeight)
        
        emailTextField.layer.cornerRadius = textFieldHeight / 2
        
        passwordLabel.frame = CGRect(x: 10,
                                     y: emailTextField.bottom + 10,
                                     width: labelWidth,
                                     height: labelHeight)
        
        passwordTextField.frame = CGRect(x: 15,
                                         y: passwordLabel.bottom + 10,
                                         width: textFieldWidth,
                                         height: textFieldHeight)
        
        passwordTextField.layer.cornerRadius = textFieldHeight / 2
        
        signInButton.frame = CGRect(x: 20,
                                    y: passwordTextField.bottom + 50,
                                    width: buttonWidth,
                                    height: buttonHeight)
        
        signInButton.layer.cornerRadius = buttonHeight / 2
        
        signUpButton.frame = CGRect(x: 20,
                                    y: signInButton.bottom + 20,
                                    width: buttonWidth,
                                    height: buttonHeight)
        
        signUpButton.layer.cornerRadius = buttonHeight / 2
        
    }

}

