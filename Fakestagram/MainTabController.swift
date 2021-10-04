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
    
    let feed = FeedController()
    let notifications = NotificationsController()
    let search = SearchController()
    let imageSelector = ImageSelectorController()
    let profile = ProfileController()
    
    viewControllers = [feed, notifications, search, imageSelector, profile]
  }
  
}
