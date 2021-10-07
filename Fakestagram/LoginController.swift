//
//  LoginController.swift
//  Fakestagram
//
//  Created by Gonzalo Alfonso on 05/10/2021.
//

import UIKit

protocol AuthenticationDelegate: AnyObject {
  func authenticationDidComplete()
}

class LoginController: UIViewController {
  
  private var viewModel = LoginViewModel()
  weak var delegate: AuthenticationDelegate?
  
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
    let button = CustomLoginButton(buttonTitle: "Log In")
    button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
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
    button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
    return button
  }()
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureUI()
    configureNotificationObservers()
  }
  
  // MARK: - Actions
  @objc func handleLogin() {
    guard let email = emailTextField.text,
          let password = passwordTextField.text else { return }
    AuthService.logUserIn(email: email, password: password) { result, error in
      if let error = error {
        self.showMessage(withTitle: "Error", message: error.localizedDescription)
      }
      self.delegate?.authenticationDidComplete()
    }
  }
  
  @objc func handleShowSignUp() {
    let controller = RegistrationController()
    controller.delegate = delegate
    navigationController?.pushViewController(controller, animated: true)
  }
  
  @objc func textDidChange(sender: UITextField) {
    if sender == emailTextField {
      viewModel.email = sender.text
    } else {
      viewModel.password = sender.text
    }
    updateForm()
  }
  
  // MARK: - Methods
  func configureUI() {
    configureGradientLayer()
    navigationController?.navigationBar.isHidden = true
    navigationController?.navigationBar.barStyle = .black
    
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
  
  func configureNotificationObservers() {
    emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
  }
}

extension LoginController: FormViewModel {
  func updateForm() {
    loginButton.backgroundColor = viewModel.buttonBackgroundColor
    loginButton.isEnabled = viewModel.formIsValid
    loginButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
  }
}
