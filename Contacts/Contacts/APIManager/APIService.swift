//
//  APIService.swift
//  Contacts
//
//  Created by Anudeep Gone on 16/10/21.
//

import Foundation

enum APIError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        }
    }
}

protocol APIServiceProtocol {
    func request<T: Codable>(router: Router, parameters: T?, completion: @escaping (Result<T, APIError>) -> ())
}

class APIService: APIServiceProtocol {
    var dataTask: URLSessionDataTask?
    let defaultSession = URLSession(configuration: .default)
    
    func request<T: Codable>(router: Router, parameters: T?, completion: @escaping (Result<T, APIError>) -> ()) {
        
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path
        if router.parameters.count != 0 {
            components.queryItems = router.parameters
        }
        
        guard let url = components.url else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let params = parameters {
            guard let data = try? JSONEncoder().encode(params) else {
                completion(.failure(.invalidData))
                return
            }
            urlRequest.httpBody = data
        }
        
        dataTask = defaultSession.dataTask(with: urlRequest) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.requestFailed))
                return
            }
            
            if httpResponse.statusCode == 200 {
                guard let data = data  else {
                    completion(.failure(.invalidData))
                    return
                }
                guard let genericModel = try? JSONDecoder().decode(T.self, from: data)  else {
                    completion(.failure(.jsonConversionFailure))
                    return
                }
                completion(.success(genericModel))
            } else {
                completion(.failure(.responseUnsuccessful))
            }
        }
        dataTask?.resume()
    }
}
