//
//  Contact.swift
//  Contacts
//
//  Created by Anudeep Gone on 16/10/21.
//

import Foundation

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
    
    var contactId: String {
        guard let id = id else {
            return "N/A"
        }
        return String(id)
    }
}

struct ContactSection {
    let sectionTitle: String
    let contacts: [Contact]
}
