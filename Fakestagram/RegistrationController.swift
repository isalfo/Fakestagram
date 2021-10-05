//
//  RegistrationController.swift
//  Fakestagram
//
//  Created by Gonzalo Alfonso on 05/10/2021.
//

import UIKit

class RegistrationController: UIViewController {
  
  // MARK: - Properties
  private var viewModel = RegistrationViewModel()
  
  private let plushPhotoButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
    button.tintColor = .white
    button.addTarget(self, action: #selector(handleProfilePhotoSelect), for: .touchUpInside)
    return button
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
  
  private let fullnameTextField = CustomTextField(placeholder: "Fullname")
    private let usernameTextField = CustomTextField(placeholder: "Username")
    private let signupButton = CustomLoginButton(buttonTitle: "Sign Up")
  
  private let alreadyHaveAccountButton: UIButton = {
    let button = UIButton(type: .system)
    button.attributedTitle(firstPart: "Already have an account?", secondPart: "Log In")
    button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
    return button
  }()
  
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureUI()
    configureNotificationObservers()
  }
  
  // MARK: - Actions
  @objc func handleShowLogin() {
    navigationController?.popViewController(animated: true)
  }
  
  @objc func textDidChange(sender: UITextField) {
    
    switch sender {
    case emailTextField:
      viewModel.email = sender.text
    case passwordTextField:
      viewModel.password = sender.text
    case usernameTextField:
      viewModel.username = sender.text
    case fullnameTextField:
      viewModel.fullname = sender.text
    default:
      showMessage(withTitle: "Error", message: "Sender not found")
    }
    
    updateForm()
  }
  
  @objc func handleProfilePhotoSelect() {
    let picker = UIImagePickerController()
    picker.delegate = self
    picker.allowsEditing = true
    
    present(picker, animated: true, completion: nil)
  }
  
  // MARK: - Methods
  func configureUI() {
    configureGradientLayer()
    
    view.addSubview(plushPhotoButton)
    plushPhotoButton.centerX(inView: view)
    plushPhotoButton.setDimensions(height: 140, width: 140)
    plushPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
    
    let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, fullnameTextField, usernameTextField, signupButton])
    stack.axis = .vertical
    stack.spacing = 20
    
    view.addSubview(stack)
    stack.anchor(top: plushPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
    
    view.addSubview(alreadyHaveAccountButton)
    alreadyHaveAccountButton.centerX(inView: view)
    alreadyHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
  }
  
  func configureNotificationObservers() {
    emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    usernameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    fullnameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
  }
}

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let selectedImage = info[.editedImage] as? UIImage else { return }
    
    plushPhotoButton.layer.cornerRadius = plushPhotoButton.frame.width / 2
    plushPhotoButton.layer.masksToBounds = true
    plushPhotoButton.layer.borderColor = UIColor.white.cgColor
    plushPhotoButton.layer.borderWidth = 2
    plushPhotoButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
    
    self.dismiss(animated: true, completion: nil)
  }
}

extension RegistrationController: FormViewModel {
  func updateForm() {
    signupButton.backgroundColor = viewModel.buttonBackgroundColor
    signupButton.isEnabled = viewModel.formIsValid
    signupButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
  }
}
