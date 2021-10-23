//
//  ViewController.swift
//  GitRepoInfo
//
//  Created by Naw Su Su Nyein on 10/23/21.
//

import UIKit

class RepositoriesListViewController: UIViewController, UISearchBarDelegate, UISearchResultsUpdating{
   
    @IBOutlet weak var repositoryTable : UITableView!
    
    var searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerTable()
        self.setupSearchBar()
    }

    func registerTable(){
        repositoryTable.register(UINib(nibName: "RepositoriesListTableViewCell", bundle: nil), forCellReuseIdentifier: "repositoryCell")
    }
    
    func setupSearchBar(){
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchBar.delegate = self
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search with name"
        self.repositoryTable.tableHeaderView = self.searchController.searchBar
    }

    func updateSearchResults(for searchController: UISearchController) {
        
    }
    

}

extension RepositoriesListViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repositoryCell", for: indexPath) as! RepositoriesListTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 161
    }
    
}
