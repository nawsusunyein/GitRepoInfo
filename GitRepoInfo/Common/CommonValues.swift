//
//  CommonValues.swift
//  GitRepoInfo
//
//  Created by Naw Su Su Nyein on 10/23/21.
//

import Foundation

struct SearchBarValues{
    static let searchBarPlaceholder = "Search with repo name"
}

struct API{
    static let repoHostName = "https://api.github.com"
}

struct URLPath{
    static let search = "/search"
}

struct EndPoints{
    static let repositories = "/repositories"
}

struct QueryKeys{
    static let q = "q"
}

struct QueryValues{
    static let repositories = "repositories"
}

struct ScreenTitle{
    static let titleRepositoriesList = "Repositories"
}

enum APIError : Error{
    case mimeError
    case serverError
    case otherError
}

struct ErrorType{
    static let mimeError = "Mime Type Error"
    static let serverError = "Server Side Error"
    static let otherError = "Other Error"
}

struct ErrorMessage{
    static let mimeErrorMsg = "Please check mime type"
    static let serverErrorMsg = "Please check internet connection (or) \n request headers in API (or) \n Server side"
    static let otherErrorMsg = "Please check data response type conversion"
}

struct MIMEType{
    static let jsonType = "application/json"
}

struct AlertActionButtonTitle{
    static let okTitle = "OK"
}
