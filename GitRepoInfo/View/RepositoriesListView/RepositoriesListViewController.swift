//
//  ViewController.swift
//  GitRepoInfo
//
//  Created by Naw Su Su Nyein on 10/23/21.
//

import UIKit

class RepositoriesListViewController: GitRepoMainViewController, UISearchBarDelegate, UISearchResultsUpdating{
   
    @IBOutlet weak var repositoryTable : UITableView!
    @IBOutlet weak var loading : UIActivityIndicatorView!
    
    var searchController = UISearchController()
    var presenter : GitRepoPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = GitRepoPresenter(view: self, service: NetworkServices())
        self.registerTable()
        self.setupSearchBar()
        self.setNavigationTitle(screenTitle : ScreenTitle.titleRepositoriesList)
    }

    
    func registerTable(){
        repositoryTable.register(UINib(nibName: "RepositoriesListTableViewCell", bundle: nil), forCellReuseIdentifier: "repositoryCell")
    }
    
    func setupSearchBar(){
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchBar.delegate = self
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = SearchBarValues.searchBarPlaceholder
        self.repositoryTable.tableHeaderView = self.searchController.searchBar
    }

    func updateSearchResults(for searchController: UISearchController) {
        self.presenter?.getResultForSearchingWithName(searchText : searchController.searchBar.text)
    }
    
    
}

extension RepositoriesListViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchController.isActive ? self.presenter?.filterRepoItems?.count ?? 0 : self.presenter?.repoItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repositoryCell", for: indexPath) as! RepositoriesListTableViewCell
        var repoItem : GitItems?
        if(searchController.isActive == true){
            repoItem = self.presenter?.filterRepoItems?[indexPath.row]
        }else{
            repoItem = self.presenter?.repoItems?[indexPath.row]
        }
        cell.bindDataForRepoItem(repoItem: repoItem)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 161
    }
    
}

extension RepositoriesListViewController : GitRepoPresenterView{
    func success() {
        DispatchQueue.main.async{
            self.repositoryTable.reloadData()
        }
    }
    
    func failure(errorType: String,errorMessage : String) {
        DispatchQueue.main.async {
            self.showErrorMessage(title : errorType, message : errorMessage)
        }
    }
    
    func getResultsForSearchWithRepoName(){
        DispatchQueue.main.async {
            self.repositoryTable.reloadData()
        }
    }
    
    func startShowingLoading(){
        DispatchQueue.main.async {
            self.loading.isHidden = false
            self.loading.startAnimating()
        }
    }
    
    func endShowingLoading(){
        DispatchQueue.main.async {
            self.loading.isHidden = true
            self.loading.stopAnimating()
        }
    }
    
}
