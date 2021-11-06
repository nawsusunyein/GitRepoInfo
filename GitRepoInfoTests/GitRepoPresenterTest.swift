//
//  GitRepoPresenterTest.swift
//  GitRepoInfoTests
//
//  Created by Naw Su Su Nyein on 10/25/21.
//

import XCTest
@testable import GitRepoInfo

class GitRepoPresenterTest: XCTestCase {

    private var gitRepPresenterViewMock : GitRepoPresenterViewMock!
    private var service : NetworkServices!
    private var presenter : GitRepoPresenter!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        gitRepPresenterViewMock = GitRepoPresenterViewMock()
        service = NetworkServices()
        presenter = GitRepoPresenter(view : gitRepPresenterViewMock, service : self.service)
       
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    //Testing whether presenter can call getResultsForSearchWithRepoName function or not in presenter view
    func testFilterResultsSearchedByString(){
        self.presenter.getResultForSearchingWithName(searchText: "l")
        XCTAssertTrue(gitRepPresenterViewMock.isShowResultSearchedByName)
    }

    
    //Testing whether presenter can call startShowingLoading function or not in presenter view
    func testShowLoading(){
        self.gitRepPresenterViewMock.startShowingLoading()
        XCTAssertTrue(gitRepPresenterViewMock.isShowLoading)
    }
    
    
    //Testing whether presenter can call endShowingLoading function or not in presenter view
    func testHideLoading(){
        self.gitRepPresenterViewMock.endShowingLoading()
        XCTAssertFalse(gitRepPresenterViewMock.isShowLoading)
    }
    
    
    //Testing whether presenter can call success function or not in presenter view after API returns value
    func testGetRepoListAPICallSuccess(){
        self.setCorrectApiHeaderForRepoListApi()
        DispatchQueue.main.async {
            XCTAssertTrue(self.gitRepPresenterViewMock.isAPICallSuccess)
        }
        
    }
    
    func testSumOfTwoValues(){
        let _ = self.presenter.calculateTwoValues(a: 10, b: 20)
        XCTAssertTrue(self.gitRepPresenterViewMock.isSumVaue)
    }
    
    //Testing whether presenter can call failure function or not in presenter view when API gets error
    func testGetRepoListAPICallFailure(){
        self.setWrongApiHeaderForRepoListApi()
        DispatchQueue.main.async {
            XCTAssertTrue(self.gitRepPresenterViewMock.isAPICallFailure)
        }
        
    }
    
    //Create API correct url and correct header and pass to network function
    func setCorrectApiHeaderForRepoListApi(){
        guard var components = URLComponents(string: API.repoHostName + URLPath.search + EndPoints.repositories)else {return}
        components.queryItems = [URLQueryItem(name: QueryKeys.q, value: QueryValues.repositories)]
        let request = URLRequest(url: components.url!)
        let promise = expectation(description: "Can get data successfully")
        self.getRepositoryList(urlRequest: request, promise: promise)
    }
    
    
    //Create API wrong url and wrong header and pass to network function
    func setWrongApiHeaderForRepoListApi(){
        guard var components = URLComponents(string: "https://api.gi.com/search/re")else {return}
        components.queryItems = [URLQueryItem(name: "w", value: "b")]
        let request = URLRequest(url: components.url!)
        let promise = expectation(description: "Can't get data successfully")
        self.getRepositoryList(urlRequest: request, promise: promise, failCase: true)
    }
    
    
    //Call api according to url request
    func getRepositoryList(urlRequest : URLRequest, promise : XCTestExpectation, failCase : Bool = false){
        
        let presenterViewMock : GitRepoPresenterViewMock = GitRepoPresenterViewMock()
        // when
      URLSession.shared.dataTask(with: urlRequest) { data, response, error in
          // then
          guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else{
             if(failCase == true){
                presenterViewMock.failure(errorType: ErrorType.serverError, errorMessage: ErrorMessage.serverErrorMsg)
                promise.fulfill()
              }
             
              return
          }
          
          guard let mime = response?.mimeType, mime == "application/json" else{
            if(failCase == true){
                presenterViewMock.failure(errorType: ErrorType.mimeError, errorMessage: ErrorMessage.mimeErrorMsg)
                promise.fulfill()
            }
           
              return
          }
          
          do{
                _ = try JSONDecoder().decode(GitRepositories.self, from: data!)
                presenterViewMock.success()
                promise.fulfill()
            }catch{
                if(failCase == true){
                    presenterViewMock.failure(errorType: ErrorType.otherError, errorMessage: ErrorMessage.otherErrorMsg)
                    promise.fulfill()
                }
                
          }
        
        }.resume()
      wait(for: [promise], timeout: 5)
    }
}

class GitRepoPresenterViewMock : GitRepoPresenterView{
   
    
    
    var isShowResultSearchedByName : Bool = false
    var isShowLoading : Bool = false
    var isAPICallSuccess : Bool = false
    var isAPICallFailure : Bool = false
    var isSumVaue : Bool = false
    
    func success() {
        isAPICallSuccess = true
    }
    
    func failure(errorType: String, errorMessage: String) {
        isAPICallFailure = true
    }
    
    func getResultsForSearchWithRepoName() {
        isShowResultSearchedByName = true
    }
    
    func startShowingLoading() {
        isShowLoading = true
    }
    
    func endShowingLoading() {
        isShowLoading = false
    }
    
    func sumOfTwoValues(total: Int) {
        isSumVaue = true
    }
  
}


