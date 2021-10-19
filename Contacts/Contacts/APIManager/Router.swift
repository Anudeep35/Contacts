//
//  Router.swift
//  Contacts
//
//  Created by Anudeep Gone on 16/10/21.
//

import Foundation

struct EndPoint {
    static let users = "/api/users"
}

enum RequestType: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
}

enum Router {
    case getContacts(page: Int)
    case updateContact(id: Int, request: Contact)
    
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "reqres.in"
    }
    
    var path: String {
        switch self {
        case .getContacts:
            return EndPoint.users
        case .updateContact(let id, _):
            let endPoint = EndPoint.users
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
            return RequestType.get.rawValue
        case .updateContact(let id, _):
            if id != 0 {
                return RequestType.put.rawValue
            }
            return RequestType.post.rawValue
        }
    }
    
    var body: Data? {
        switch self {
        case .getContacts:
            return nil
        case .updateContact(let id, let request):
            if id != 0 { return nil }
            guard let data = try? JSONEncoder().encode(request) else {
                return nil
            }
            return data
        }
    }
}
