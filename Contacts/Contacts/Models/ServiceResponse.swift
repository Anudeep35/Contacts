//
//  ServiceResponse.swift
//  Contacts
//
//  Created by Anudeep Gone on 20/10/21.
//

import Foundation

struct ServiceResponse: Codable {
    let page: Int
    let data: [Contact]
}
