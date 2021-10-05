//
//  MainTabController.swift
//  Fakestagram
//
//  Created by Gonzalo Alfonso on 04/10/2021.
//

import UIKit
// MARK: - MainTabBarController class
class MainTabController: UITabBarController {
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewControllers()
    
  }
  
  // MARK: - Methods
  private func configureViewControllers() {
    view.backgroundColor = #colorLiteral(red: 1, green: 0.683874047, blue: 0.6514579047, alpha: 1)
    
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.itemSize = CGSize(width: 50, height: 50)

    let feed = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewController: FeedController(collectionViewLayout: layout))
    let notifications = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected"), rootViewController: NotificationsController())
    let search = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected"), rootViewController: SearchController())
    let imageSelector = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected"), rootViewController: ImageSelectorController())
    let profile = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected"), rootViewController: ProfileController())
    
    viewControllers = [feed, notifications, imageSelector, search, profile]
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
