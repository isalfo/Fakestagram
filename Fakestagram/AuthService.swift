//
//  AuthService.swift
//  Fakestagram
//
//  Created by Gonzalo Alfonso on 06/10/2021.
//

import UIKit
import Firebase

struct AuthCredentials {
  let email: String
  let password: String
  let fullname: String
  let username: String
  let profileImage: UIImage
}

struct AuthService {
  static func logUserIn(email: String, password: String, completion: AuthDataResultCallback?) {
    Auth.auth().signIn(withEmail: email, password: password, completion: completion)
  }
  
  static func resgisterUser(withCredential credential: AuthCredentials, completion: @escaping(Error?) -> Void) {
    
    ImageUploader.uploadImage(image: credential.profileImage) { imageURL in
      
      Auth.auth().createUser(withEmail: credential.email, password: credential.password) { result, error in
        
        if let error = error {
          print("DEBUG: \(error.localizedDescription)")
          return
        }
        
        guard let uid = result?.user.uid else { return }
        
        let data: [String: Any] = ["email": credential.email,
                                   "fullname": credential.fullname,
                                   "profileImageUrl": imageURL,
                                   "uid":uid,
                                   "username":credential.username]
        COLLECTION_USERS.document(uid).setData(data, completion: completion)
        print("DEBUG: DATA \(data)")
      }
    }
  }
}
