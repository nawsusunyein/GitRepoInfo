//
//  NetworkServices.swift
//  GitRepoInfo
//
//  Created by Naw Su Su Nyein on 10/23/21.
//

import Foundation

class NetworkServices {
    
    //Call repo list API
    func getRepositories(completion: @escaping(Result<GitRepositories,APIError>) -> Void){
        guard var components = URLComponents(string: API.repoHostName + URLPath.search + EndPoints.repositories)else {return}
        components.queryItems = [URLQueryItem(name: QueryKeys.q, value: QueryValues.repositories)]
        let request = URLRequest(url: components.url!)
        
        URLSession.shared.dataTask(with: request){data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else{
                completion(.failure(.serverError))
                return
            }
            
            guard let mime = response?.mimeType, mime == MIMEType.jsonType else{
                completion(.failure(.mimeError))
                return
            }
            
            do{
                let repositories = try JSONDecoder().decode(GitRepositories.self, from: data!)
                completion(.success(repositories))
            }catch{
                completion(.failure(.otherError))
            }
            
        }.resume()
    }
}

