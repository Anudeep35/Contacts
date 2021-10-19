//
//  MockAPIService.swift
//  ContactsTests
//
//  Created by Anudeep Gone on 20/10/21.
//

import Foundation
@testable import Contacts

class MockAPIService: APIServiceProtocol {
        
    func request<T: Codable>(router: Router, completion: @escaping (Result<T, APIError>) -> ()) {
        let testBundle = Bundle(for: type(of: self))
        if router.path == EndPoint.users {
            var file = "Contacts"
            if router.method == RequestType.get.rawValue {
                completion(.success(testBundle.decode(ServiceResponse.self, from: file) as! T))
            }
            else if router.method == RequestType.put.rawValue {
                file = "AddNewContact"
                completion(.success(testBundle.decode(UpdateResponse.self, from: file) as! T))
            } else if router.method == RequestType.post.rawValue {
                file = "UpdateContact"
                completion(.success(testBundle.decode(UpdateResponse.self, from: file) as! T))
            }
            
        }
    }
}

extension Bundle {
    func decode<T: Codable>(_ type: T.Type, from file: String) -> T? {
        guard let url = self.url(forResource: file, withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let genericModel = try? JSONDecoder().decode(T.self, from: data) else {
            return nil
        }
        return genericModel
    }
}
