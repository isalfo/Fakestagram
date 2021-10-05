//
//  AuthenticationViewModel.swift
//  Fakestagram
//
//  Created by Gonzalo Alfonso on 05/10/2021.
//

import UIKit

protocol FormViewModel {
  func updateForm()
}

protocol AuthenticationViewModel {
  var formIsValid: Bool { get }
  var buttonBackgroundColor: UIColor { get }
  var buttonTitleColor: UIColor { get }
}

struct LoginViewModel: AuthenticationViewModel {
  var email: String?
  var password: String?
  
  var formIsValid: Bool {
    return email?.isEmpty == false && password?.isEmpty == false
  }
  
  var buttonBackgroundColor: UIColor {
    return formIsValid ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).withAlphaComponent(0.5)
  }
  
  var buttonTitleColor: UIColor {
    return formIsValid ? .systemPink : .systemPink.withAlphaComponent(0.5)
  }
}



struct RegistrationViewModel: AuthenticationViewModel {
  
  var email: String?
  var password: String?
  var fullname: String?
  var username: String?
  
  var formIsValid: Bool {
    return email?.isEmpty == false && password?.isEmpty == false && fullname?.isEmpty == false && username?.isEmpty == false 
  }
  
  var buttonBackgroundColor: UIColor {
    return formIsValid ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).withAlphaComponent(0.5)
  }
  
  var buttonTitleColor: UIColor {
    return formIsValid ? .systemPink : .systemPink.withAlphaComponent(0.5)
  }
}
