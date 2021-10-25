//
//  GitRepoListAPITests.swift
//  GitRepoInfoTests
//
//  Created by Naw Su Su Nyein on 10/25/21.
//

import XCTest
@testable import GitRepoInfo

class GitRepoListAPITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        
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
    
    func testGetRepoListAPICallWithCorrectHostAndEndPoints(){
       
        guard var components = URLComponents(string: API.repoHostName + URLPath.search + EndPoints.repositories)else {return}
        components.queryItems = [URLQueryItem(name: QueryKeys.q, value: QueryValues.repositories)]
        let request = URLRequest(url: components.url!)
        let promise = expectation(description: "Can get data successfully")
        self.getRepositoryList(urlRequest: request, promise: promise)
    }

    func testGetRepoListAPICallFailWithWrongHostName(){
        guard let components = URLComponents(string: "https://api.giu.com/search/repositories") else {return}
        let request = URLRequest(url: components.url!)
        let promise = expectation(description: "Can't get data and host name is wrong")
        self.getRepositoryList(urlRequest: request, promise: promise, failCase: true)
    }
    
    func testGetRepoListApiCallComplete(){
        guard var components = URLComponents(string: API.repoHostName + URLPath.search + EndPoints.repositories)else {return}
        components.queryItems = [URLQueryItem(name: QueryKeys.q, value: QueryValues.repositories)]
        let request = URLRequest(url: components.url!)
        let promise = expectation(description: "Can get data successfully")
        self.getRepositoryList(urlRequest: request, promise: promise, isTestApiCallComplete: true)
    }
    
    func getRepositoryList(urlRequest : URLRequest, promise : XCTestExpectation, failCase : Bool = false, isTestApiCallComplete : Bool = false){
        
        var statusCode: Int?
        var responseError: Error?
        
        // when
      URLSession.shared.dataTask(with: urlRequest) { data, response, error in
          // then
          guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else{
              XCTFail("Server Error : \(error?.localizedDescription)")
             if(failCase == true){
                promise.fulfill()
              }
              return
          }
          
          guard let mime = response?.mimeType, mime == "application/json" else{
              XCTFail("MIME Error : \(String(describing: error?.localizedDescription))")
            if(failCase == true){
                promise.fulfill()
            }
              return
          }
          
          do{
            print("promise value : \(promise.description)")
              _ = try JSONDecoder().decode(GitRepositories.self, from: data!)
            if(isTestApiCallComplete == true){
                statusCode = (response as? HTTPURLResponse)?.statusCode
                responseError = error
            }
              promise.fulfill()
            
          }catch{
            if(failCase == true){
                promise.fulfill()
            }
              XCTFail("Decodable Error : \(String(describing: error.localizedDescription))")
          }
        
        if(isTestApiCallComplete == true){
            XCTAssertNil(responseError)
            XCTAssertEqual(statusCode, 200)
        }
          
      }.resume()
      wait(for: [promise], timeout: 5)
    }
}

