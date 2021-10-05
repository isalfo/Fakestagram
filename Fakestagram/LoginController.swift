//
//  LoginController.swift
//  Fakestagram
//
//  Created by Gonzalo Alfonso on 05/10/2021.
//

import UIKit

class LoginController: UIViewController {
  
  // MARK: - Properties
  private let iconImage: UIImageView = {
    let iv = UIImageView(image: #imageLiteral(resourceName: "Instagram_logo_white"))
    iv.contentMode = .scaleAspectFill
    return iv
  }()
  private let emailTextField: UITextField = {
    let tf = CustomTextField(placeholder: "Email")
    tf.keyboardType = .emailAddress
    return tf
  }()
  
  private let passwordTextField: UITextField = {
    let tf = CustomTextField(placeholder: "Password")
    tf.isSecureTextEntry = true
    return tf
  }()
  
  private let loginButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Log In", for: .normal)
    button.setTitleColor(.systemPink, for: .normal)
    button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
    button.layer.cornerRadius = 5
    button.setHeight(50)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    return button
  }()
  
  private let forgotPasswordButton: UIButton = {
    let button = UIButton(type: .system)
    button.attributedTitle(firstPart: "Forgot your password?", secondPart: "Get help signing in.")
    return button
  }()
  
  private let dontHaveAccountButton: UIButton = {
    let button = UIButton(type: .system)
    button.attributedTitle(firstPart: "Don't have an account?", secondPart: "Sign Up")    
    return button
  }()
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureUI()
  }
  
  // MARK: - Methods
  func configureUI() {
    view.backgroundColor = .systemPurple
    navigationController?.navigationBar.isHidden = true
    navigationController?.navigationBar.barStyle = .black
    
    let gradient = CAGradientLayer()
    gradient.colors = [UIColor.systemPink.cgColor, UIColor.systemPurple.cgColor]
    gradient.locations = [0, 1]
    view.layer.addSublayer(gradient)
    gradient.frame = view.frame
    
    view.addSubview(iconImage)
    iconImage.centerX(inView: view)
    iconImage.setDimensions(height: 80, width: 120)
    iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
    
    let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton, forgotPasswordButton])
    stack.axis = .vertical
    stack.spacing = 20
    
    view.addSubview(stack)
    stack.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
    
    view.addSubview(dontHaveAccountButton)
    dontHaveAccountButton.centerX(inView: view)
    dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
  }
}
