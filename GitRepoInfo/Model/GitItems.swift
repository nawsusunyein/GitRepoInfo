//
//  GitItems.swift
//  GitRepoInfo
//
//  Created by Naw Su Su Nyein on 10/23/21.
//

import Foundation

struct GitItems : Decodable{
    var name : String
    var visibility: String
    var owner : GitOwner
    var open_issues : Int
    var topics : [String]
    var license : GitLicense?
    var description: String?
}
