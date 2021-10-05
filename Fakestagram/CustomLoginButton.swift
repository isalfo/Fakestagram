//
//  CustomLoginButton.swift
//  Fakestagram
//
//  Created by Gonzalo Alfonso on 05/10/2021.
//

import UIKit

class CustomLoginButton: UIButton {
  
  init(buttonTitle: String) {
    super.init(frame: .zero)
    setTitle(buttonTitle, for: .normal)
    setTitleColor(.systemPink.withAlphaComponent(0.5), for: .normal)
    backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1).withAlphaComponent(0.5)
    isEnabled = false
    layer.cornerRadius = 5
    setHeight(50)
    titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
