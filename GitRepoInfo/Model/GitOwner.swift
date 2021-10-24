//
//  GitOwner.swift
//  GitRepoInfo
//
//  Created by Naw Su Su Nyein on 10/23/21.
//

import Foundation

struct GitOwner : Decodable{
    var avatar_url : String
    var site_admin : Bool
    var type : String
}
