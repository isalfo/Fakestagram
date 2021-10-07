//
//  ProfileHeaderViewModel.swift
//  Fakestagram
//
//  Created by Gonzalo Alfonso on 06/10/2021.
//

import UIKit

struct ProfileHeaderViewModel {
  
  let user: User
  
  var fullname: String {
    return user.fullname
  }
  
  var profileImageUrl: URL? {
    return URL(string: user.profileImageUrl)
  }
  
  var followButtonText: String {
    if user.isCurrentUser {
      return "Edit Profile"
    }
    
    return user.isFollowed ? "Unfollow" : "Follow"
  }
  
  var followButtonBackground: UIColor {
    return user.isCurrentUser ? .white : .systemBlue
  }
  
  var followButtonTextColor: UIColor {
    return user.isCurrentUser ? .black : .white
  }
  
  var numberOfFollowers: NSAttributedString {
    return attributedStatText(value: user.stats?.followers ?? 0, label: "followers")
  }
  
  var numberOfFollowing: NSAttributedString {
    return attributedStatText(value: user.stats?.following ?? 0, label: "following")
  }
  
  var numberOfPosts: NSAttributedString {
    return attributedStatText(value: 5, label: "posts")
  }
  
  init(user: User) {
    self.user = user
  }
  
  func attributedStatText(value: Int, label: String) -> NSAttributedString {
    let attributedText = NSMutableAttributedString(string: "\(value)\n", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
    attributedText.append(NSAttributedString(string: label, attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
    return attributedText
  }
}
