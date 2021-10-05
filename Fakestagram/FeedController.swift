//
//  FeedController.swift
//  Fakestagram
//
//  Created by Gonzalo Alfonso on 04/10/2021.
//

import UIKit

private let reuseIdentifier = "feedCell"

class FeedController: UICollectionViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    customizeView()
  }
  
  func customizeView() {
    collectionView.backgroundColor = .white
    
    self.collectionView.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
  }
}

extension FeedController {
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? FeedCell ?? UICollectionViewCell()
    return cell
  }
}

extension FeedController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let width = view.frame.width
    var height = width + 8 + 40 + 8
    height += 50
    height += 60
    
    
    return CGSize(width: width, height: height)
  }
}
