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
  
  static func follow(uid: String, completion: @escaping (Error?) -> Void) {
    guard let currentUid = Auth.auth().currentUser?.uid else { return }
    COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).setData([:]) { error in
      COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUid).setData([:], completion: completion)
    }
  }
  
  static func unfollow(uid: String, completion: @escaping (Error?) -> Void) {
    guard let currentUid = Auth.auth().currentUser?.uid else { return }
    COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).delete { error in
      COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUid).delete(completion: completion)
    }
  }
  
  static func checkIfUserIsFollowed(uid: String, completion: @escaping(Bool) -> Void) {
    guard let currentUid = Auth.auth().currentUser?.uid else { return }
    COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).getDocument { snapshot, error in
      guard let isFollowed = snapshot?.exists else { return }
      completion(isFollowed)
    }
  }
  
  static func checkUserStats(uid: String, completion: @escaping(UserStats) -> Void) {
    COLLECTION_FOLLOWERS.document(uid).collection("user-followers").getDocuments { snapshot, _ in
      let followers = snapshot?.documents.count ?? 0
      COLLECTION_FOLLOWING.document(uid).collection("user-following").getDocuments { snapshot, _ in
        let following = snapshot?.documents.count ?? 0
        completion(UserStats(following: following, followers: followers))
      }
    }
  }
}
