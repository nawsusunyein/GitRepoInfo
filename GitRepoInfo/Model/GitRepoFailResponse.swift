//
//  GitRepoFailResponse.swift
//  GitRepoInfo
//
//  Created by Naw Su Su Nyein on 10/24/21.
//

import Foundation

struct GitRepoFailResponse : Decodable{
    var message : String
    var errors : [GitRepoErrorResponse]
    var documentation_url : String
}
