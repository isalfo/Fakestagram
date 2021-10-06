//
//  ImageUploader.swift
//  Fakestagram
//
//  Created by Gonzalo Alfonso on 06/10/2021.
//

import FirebaseStorage

struct ImageUploader {
  static func uploadImage(image: UIImage, completion: @escaping(String) -> Void) {
    guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
    let filename = NSUUID().uuidString
    let ref = Storage.storage().reference(withPath: "profile_image\(filename)")
    
    ref.putData(imageData, metadata: nil) { metadata, error in
      if let error = error {
        print("DEBUG: \(error.localizedDescription)")
        return
      }
      
      ref.downloadURL { url, error in
        guard let imageURL = url?.absoluteString else { return }
        completion(imageURL)
      }
    }
  }
}
