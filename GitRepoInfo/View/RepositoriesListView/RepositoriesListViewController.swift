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
        self.initializePresenter()
        self.registerTable()
        self.setupSearchBar()
        self.setNavigationTitle(screenTitle : ScreenTitle.titleRepositoriesList)
    }
    
    //Initialize presenter to make logic operation and API call
    
    func initializePresenter(){
        self.presenter = GitRepoPresenter(view: self, service: NetworkServices())
    }
    
    
    //Register table view cell in table view
    
    func registerTable(){
        repositoryTable.register(UINib(nibName: "RepositoriesListTableViewCell", bundle: nil), forCellReuseIdentifier: "repositoryCell")
    }
    
    
    //Set search bar in table view
    
    func setupSearchBar(){
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchBar.delegate = self
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = SearchBarValues.searchBarPlaceholder
        self.repositoryTable.tableHeaderView = self.searchController.searchBar
    }
    
    //Get results searched with repo name
    func updateSearchResults(for searchController: UISearchController) {
        self.presenter?.getResultForSearchingWithName(searchText : searchController.searchBar.text)
    }
}

extension RepositoriesListViewController : UITableViewDelegate, UITableViewDataSource{
    
    //Return number of rows in table view
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchController.isActive ? self.presenter?.filterRepoItems?.count ?? 0 : self.presenter?.repoItems?.count ?? 0
    }
    
    
    //Get results according to table row and pass object values to bind function to show data
    
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
    
    
    //Set height for table view cell
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 161
    }
    
}

extension RepositoriesListViewController : GitRepoPresenterView{
    
    //Reload table view after API call is succeded from presenter
    
    func success() {
        DispatchQueue.main.async{
            self.repositoryTable.reloadData()
        }
    }
    
    
    //Show error alert after API call is failed from presenter
    
    func failure(errorType: String,errorMessage : String) {
        DispatchQueue.main.async {
            self.showErrorMessage(title : errorType, message : errorMessage, buttonTitle: AlertActionButtonTitle.okTitle)
        }
    }
    
    
    //Reload table view to show resulted values searched with repo name
    
    func getResultsForSearchWithRepoName(){
        DispatchQueue.main.async {
            self.repositoryTable.reloadData()
        }
    }
    
    
    //Show loading when presenter call API
    func startShowingLoading(){
        DispatchQueue.main.async {
            self.loading.isHidden = false
            self.loading.startAnimating()
        }
    }
    
    
    //Hide loading when API call has finished
    func endShowingLoading(){
        DispatchQueue.main.async {
            self.loading.isHidden = true
            self.loading.stopAnimating()
        }
    }
    
}
