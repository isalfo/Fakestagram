//
//  MainTabController.swift
//  Fakestagram
//
//  Created by Gonzalo Alfonso on 04/10/2021.
//

import UIKit
import Firebase

// MARK: MainTabBarController class
class MainTabController: UITabBarController {
  
  // MARK: - Properties
  private var user: User? {
    didSet {
      guard let user = user else { return }
      configureViewControllers(withUser: user)
    }
  }
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    checkIfUserIsLoggedIn()
    fetchUser()
  }
  
  // MARK: - API
  func checkIfUserIsLoggedIn() {
    if Auth.auth().currentUser == nil {
      DispatchQueue.main.async {
        let controller = LoginController()
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
      }
    }
  }
  
  func fetchUser() {
    UserService.fetchUser { user in
      self.user = user
    }
  }
  
  // MARK: - Methods
  private func configureViewControllers(withUser user: User) {
    view.backgroundColor = #colorLiteral(red: 1, green: 0.683874047, blue: 0.6514579047, alpha: 1)
    
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.itemSize = CGSize(width: 50, height: 50)

    let feed = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewController: FeedController(collectionViewLayout: layout))
    let notifications = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected"), rootViewController: NotificationsController())
    let search = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected"), rootViewController: SearchController())
    let imageSelector = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected"), rootViewController: ImageSelectorController())
    let profileController = ProfileController(user: user)
    let profile = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected"), rootViewController: profileController)
    
    viewControllers = [feed, search, imageSelector, notifications, profile]
    tabBar.tintColor = .black
  }
  
  func templateNavigationController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController) -> UINavigationController {
    let nav = UINavigationController(rootViewController: rootViewController)
    nav.tabBarItem.image = unselectedImage
    nav.tabBarItem.selectedImage = selectedImage
    nav.navigationBar.tintColor = .black
    return nav
  }
}

extension MainTabController: AuthenticationDelegate {
  func authenticationDidComplete() {
    fetchUser()
    self.dismiss(animated: true, completion: nil)
  }
}
