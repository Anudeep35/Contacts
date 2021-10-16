//
//  Contact.swift
//  Contacts
//
//  Created by Anudeep Gone on 16/10/21.
//

import Foundation

struct ServiceResponse: Codable {
    let page: Int
    let data: [Contact]
}

struct Contact: Codable {
    let id: Int?
    let firstName: String?
    let lastName: String?
    let avatar: String?
    let email: String?
    
    private enum CodingKeys: String, CodingKey {
            case id, firstName = "first_name", lastName = "last_name", avatar, email
        }
    
    var fullName: String {
        if firstName == nil && lastName == nil {
            return ""
        } else if firstName == nil {
            return lastName ?? ""
        } else if lastName == nil {
            return firstName ?? ""
        } else {
            return (firstName ?? "")  + " " + (lastName ?? "")
        }
    }
    
    var avatarUrl: URL? {
        guard let avatar = avatar else {
            return  nil
        }
        return URL(string: avatar)
    }
}

struct ContactSection {
    let sectionTitle: String
    let contacts: [Contact]
}
