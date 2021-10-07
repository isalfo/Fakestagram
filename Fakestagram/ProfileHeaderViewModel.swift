//
//  ProfileHeaderViewModel.swift
//  Fakestagram
//
//  Created by Gonzalo Alfonso on 06/10/2021.
//

import Foundation

struct ProfileHeaderViewModel {
  
  var fullname: String {
    return user.fullname
  }
  
  var profileImageUrl: URL? {
    return URL(string: user.profileImageUrl)
  }
  
  let user: User
  
  init(user: User) {
    self.user = user
  }
}
