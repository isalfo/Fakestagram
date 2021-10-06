//
//  ProfileCell.swift
//  Fakestagram
//
//  Created by Gonzalo Alfonso on 06/10/2021.
//

import UIKit

class ProfileCell: UICollectionViewCell {
  
  // MARK: - Properties
  
  private let postImageView: UIImageView = {
    let iv = UIImageView()
    iv.image = #imageLiteral(resourceName: "profile")
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    return iv
  }()
  
  // MARK: - Lifecycle
  
  override init(frame: CGRect ) {
    super.init(frame: frame)
    backgroundColor = .black
    addSubview(postImageView)
    postImageView.fillSuperview()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}
