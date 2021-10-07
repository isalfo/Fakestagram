//
//  SearchController.swift
//  Fakestagram
//
//  Created by Gonzalo Alfonso on 04/10/2021.
//

import UIKit

private var reuseIdentifier = "UserCell"

class SearchController: UITableViewController {
  
  // MARK: - Properties
  
  private var users = [User]()
  private var filteredUsers = [User]()
  private let searchController = UISearchController(searchResultsController: nil)
  private var inSearchMode: Bool {
    return searchController.isActive && !(searchController.searchBar.text?.isEmpty ?? false)
  }
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureSearchController()
    configureTableView()
    fetchUsers()
    
  }
  
  // MARK: - Methods
  func fetchUsers() {
    UserService.fetchUsers { users in
      self.users = users
      self.tableView.reloadData()
    }
  }
  func configureTableView() {
    view.backgroundColor = .white
    
    tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
    tableView.rowHeight = 64
  }
  
  func configureSearchController() {
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.hidesNavigationBarDuringPresentation = false
    searchController.searchBar.placeholder = "Search"
    navigationItem.searchController = searchController
    definesPresentationContext = false
  }
}

// MARK: - UITableViewDataSource

extension SearchController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return inSearchMode ? filteredUsers.count : users.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier,for: indexPath) as! UserCell
    let user = inSearchMode ? filteredUsers[indexPath.row] : users[indexPath.row]
    cell.viewModel = UserCellViewModel(user: user)
    return cell
  }
}

extension SearchController {
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let user = inSearchMode ? filteredUsers[indexPath.row] : users[indexPath.row]
    let controller = ProfileController(user: user)
    navigationController?.pushViewController(controller, animated: true)
  }
}

extension SearchController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    guard let searchText = searchController.searchBar.text?.lowercased() else { return }
    filteredUsers = users.filter({ $0.username.contains(searchText) || $0.fullname.lowercased().contains(searchText)})
    self.tableView.reloadData()
  }
}
