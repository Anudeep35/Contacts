//
//  Router.swift
//  Contacts
//
//  Created by Anudeep Gone on 16/10/21.
//

import Foundation

enum Router {
    case getContacts(page: Int)
    
    var scheme: String {
        switch self {
        case .getContacts:
            return "https"
        }
    }
    
    var host: String {
        switch self {
        case .getContacts:
            return "reqres.in"
        }
    }
    
    var path: String {
        switch self {
        case .getContacts:
            return "/api/users"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getContacts(let page):
            return [URLQueryItem(name: "page", value: String(page))]
        }
    }
    
    var method: String {
        switch self {
        case .getContacts:
            return "GET"
        }
    }
}
