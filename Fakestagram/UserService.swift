//
//  UserService.swift
//  Fakestagram
//
//  Created by Gonzalo Alfonso on 06/10/2021.
//

import Firebase

struct UserService {
  static func fetchUser(completion: @escaping(User) -> Void) {
    guard let userid = Auth.auth().currentUser?.uid else { return }
    COLLECTION_USERS.document(userid).getDocument { snapshot, error in
      if let error = error {
        print(error.localizedDescription)
      }
      
      guard let dictionary = snapshot?.data() else { return }
      
      let user = User(dictionary: dictionary)
      
      completion(user)
    }
  }
  
  static func fetchUsers(completion: @escaping([User]) -> Void) {
    
    COLLECTION_USERS.getDocuments { snapshot, error in
      guard let snapshot = snapshot else { return }
      
      let users = snapshot.documents.map({ User(dictionary: $0.data()) })
      completion(users)
    }
  }
}
