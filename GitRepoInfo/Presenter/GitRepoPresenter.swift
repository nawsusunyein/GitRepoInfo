//
//  GitRepoPresenter.swift
//  GitRepoInfo
//
//  Created by Naw Su Su Nyein on 10/23/21.
//

import Foundation

protocol GitRepoPresenterView : class{
    func success()
    func failure(errorMessage : String)
    func getResultsForSearchWithRepoName()
}

class GitRepoPresenter {
    var repoItems : [GitItems]?
    var filterRepoItems : [GitItems]?
   
    private weak var gitRepoListPresenterView : GitRepoPresenterView?
    private weak var networkService : NetworkServices?
    
    init(view : GitRepoPresenterView, service : NetworkServices){
        self.gitRepoListPresenterView = view
        self.networkService = service
        self.getRepositories()
    }
    
    func getRepositories(){
        networkService?.getRepositories{[weak self] result in
            switch result{
            case .success(let gitRepositories):
                self?.repoItems = gitRepositories.items
                print("repositories values ; \(self?.repoItems)")
                self?.gitRepoListPresenterView?.success()
            case .failure(let error):
                let error = error.localizedDescription
                print("repositories error : \(error)")
            }
        }
    }
    
   func getResultForSearchingWithName(searchText : String?){
        if let results = searchText{
            self.filterRepoItems = self.repoItems?.filter{(repository) -> Bool in
                return repository.name.localizedCaseInsensitiveContains(results)
            }
        }
        self.gitRepoListPresenterView?.getResultsForSearchWithRepoName()
    }
}
