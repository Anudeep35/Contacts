//
//  Router.swift
//  Contacts
//
//  Created by Anudeep Gone on 16/10/21.
//

import Foundation

enum Router {
    case getContacts(page: Int)
    case updateContact(id: Int)
    
    var scheme: String {
        switch self {
        case .getContacts, .updateContact:
            return "https"
        }
    }
    
    var host: String {
        switch self {
        case .getContacts, .updateContact:
            return "reqres.in"
        }
    }
    
    var path: String {
        switch self {
        case .getContacts:
            return "/api/users"
        case .updateContact(let id):
            let endPoint = "/api/users"
            if id != 0 {
                return endPoint + "/\(id)"
            }
            return endPoint
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getContacts(let page):
            return [URLQueryItem(name: "page", value: String(page))]
        case .updateContact:
            return []
        }
    }
    
    var method: String {
        switch self {
        case .getContacts:
            return "GET"
        case .updateContact:
            return "PUT"
        }
    }
}
