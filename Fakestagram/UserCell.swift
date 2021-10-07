//
//  UserCell.swift
//  Fakestagram
//
//  Created by Gonzalo Alfonso on 07/10/2021.
//

import UIKit

class UserCell: UITableViewCell {
  
  // MARK: - Properties
  
  var viewModel: UserCellViewModel? {
    didSet { configure() }
  }
  
  private let profileImageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    iv.backgroundColor = .lightGray
    iv.image = #imageLiteral(resourceName: "profile")
    return iv
  }()
  
  private let userNameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 14)
    label.text = "Jake"
    return label
  }()
  
  private let fullnameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14)
    label.text = "sk8er"
    label.textColor = .lightGray
    return label
  }()
  
  // MARK: - Lifecycle
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    addSubview(profileImageView)
    profileImageView.setDimensions(height: 48, width: 48)
    profileImageView.layer.cornerRadius = 48 / 2
    
    profileImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
    
    let stack = UIStackView(arrangedSubviews: [userNameLabel, fullnameLabel])
    stack.axis = .vertical
    stack.spacing = 4
    stack.alignment = .leading
    
    addSubview(stack)
    stack.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 8)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Methods
  
  func configure() {
    guard let viewModel = viewModel else { return }
    
    profileImageView.sd_setImage(with: viewModel.profileImageUrl)
    userNameLabel.text = viewModel.username
    fullnameLabel.text = viewModel.fullname
  }
}
