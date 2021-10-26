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
    func startShowingLoading()
    func endShowingLoading()
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
        self.gitRepoListPresenterView?.startShowingLoading()
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
                    errorType = ErrorType.mimeError
                    errorMessage = ErrorMessage.mimeErrorMsg
                case .serverError:
                    errorType = ErrorType.serverError
                    errorMessage = ErrorMessage.serverErrorMsg
                case .otherError:
                    errorType = ErrorType.otherError
                    errorMessage = ErrorMessage.otherErrorMsg
                }
                self?.gitRepoListPresenterView?.failure(errorType: errorType,errorMessage: errorMessage)
           
            }
            self?.gitRepoListPresenterView?.endShowingLoading()
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
