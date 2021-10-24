//
//  NetworkServices.swift
//  GitRepoInfo
//
//  Created by Naw Su Su Nyein on 10/23/21.
//

import Foundation

class NetworkServices {
    func getRepositories(completion: @escaping(Result<GitRepositories,Error>) -> Void){
        guard var components = URLComponents(string: API.repoHostName + URLPath.search + EndPoints.repositories)else {return}
        components.queryItems = [URLQueryItem(name: QueryKeys.q, value: QueryValues.repositories)]
        let request = URLRequest(url: components.url!)
        URLSession.shared.dataTask(with: request){data, _, error in
            if let error = error{
                completion(.failure(error))
                return
            }
            
            do{
                let repositories = try JSONDecoder().decode(GitRepositories.self, from: data!)
                completion(.success(repositories))
            }catch{
                completion(.failure(error))
            }
        }.resume()
    }
}

