//
//  GitRepoPresenter.swift
//  GitRepoInfo
//
//  Created by Naw Su Su Nyein on 10/23/21.
//

import Foundation

protocol GitRepoPresenterView : class{
    func success()
    func failure(errorType: String,errorMessage : String)
    func getResultsForSearchWithRepoName()
}

class GitRepoPresenter {
    var repoItems : [GitItems]?
    var filterRepoItems : [GitItems]?
    var repoFailResponse : GitRepoFailResponse?
    
    private weak var gitRepoListPresenterView : GitRepoPresenterView?
    private weak var networkService : NetworkServices?
    
    init(view : GitRepoPresenterView,service : NetworkServices){
        self.gitRepoListPresenterView = view
        self.networkService = service
        self.getRepositories()
    }
        
    func getRepositories(){
        
        networkService?.getRepositories{[weak self] result in
            switch result{
            case .success(let gitRepositories):
                self?.repoItems = gitRepositories.items
                self?.gitRepoListPresenterView?.success()
                
            case .failure(let error):
                
                var errorType : String = ""
                var errorMessage : String = ""
                let apiError = error as APIError
                switch apiError{
                case .mimeError:
                    errorType = "Mime Type Error"
                    errorMessage = "Please check mime type"
                case .serverError:
                    errorType = "Server Side Error"
                    errorMessage = "Please check internet connection (or) \n request headers in API (or) \n Server side"
                case .otherError:
                    errorType = "Other Error"
                    errorMessage = "Please check data response type conversion"
                }
                self?.gitRepoListPresenterView?.failure(errorType: errorType,errorMessage: errorMessage)
           
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
