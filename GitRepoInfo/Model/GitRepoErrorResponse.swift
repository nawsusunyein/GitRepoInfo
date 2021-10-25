//
//  GitRepoErrorResponse.swift
//  GitRepoInfo
//
//  Created by Naw Su Su Nyein on 10/24/21.
//

import Foundation

struct GitRepoErrorResponse : Decodable{
    var resource : String
    var field : String
    var code : String
}
