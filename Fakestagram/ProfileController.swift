//
//  ProfileController.swift
//  Fakestagram
//
//  Created by Gonzalo Alfonso on 04/10/2021.
//

import UIKit

private let cellIdentifier = "ProfileCell"
private let headerIdentifier = "ProfileHeader"

class ProfileController: UICollectionViewController {
  
  // MARK: - Properties
  var user: User
  
  // MARK: - Lifecycle
  init(user: User) {
    self.user = user
    super.init(collectionViewLayout: UICollectionViewFlowLayout())
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureCollectionView()
    checkIfUserIsFollowed()
    fetchUserStats()
  }
  
  // MARK: - API
  
  func checkIfUserIsFollowed() {
    UserService.checkIfUserIsFollowed(uid: user.uid) { isFollowed in
      self.user.isFollowed = isFollowed
      self.collectionView.reloadData()
    }
  }
  
  func fetchUserStats() {
    UserService.checkUserStats(uid: user.uid) { stats in
      self.user.stats = stats
      self.collectionView.reloadData()
    }
  }
  
  // MARK: - Methods
  
  func configureCollectionView() {
    navigationItem.title = user.username
    collectionView.backgroundColor = .white
    collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: cellIdentifier)
    collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
  }
}

// MARK: - UICollectionViewDataSource

extension ProfileController {
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 9
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ProfileCell ?? UICollectionViewCell()
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! ProfileHeader
    header.delegate = self
      header.viewModel = ProfileHeaderViewModel(user: user)
    return header
  }
}

// MARK: - UICollectionViewDelegate

extension ProfileController {
  
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ProfileController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = (view.frame.width - 2) / 3
    return CGSize(width: width, height: width)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: view.frame.width, height: 240)
  }
  
}

extension ProfileController: ProfileHeaderDelegate {
  func header(_ profileHeader: ProfileHeader, didTapActionButtonFor user: User) {
    if user.isCurrentUser {
      debugPrint("Show edit profile")
    } else if user.isFollowed {
      UserService.unfollow(uid: user.uid) { error in
        self.user.isFollowed = false
        self.collectionView.reloadData()
      }
    } else {
      UserService.follow(uid: user.uid) { error in
        self.user.isFollowed = true
        self.collectionView.reloadData()
      }
    }
  }
}
