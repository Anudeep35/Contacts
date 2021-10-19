//
//  APIService.swift
//  Contacts
//
//  Created by Anudeep Gone on 16/10/21.
//

import Foundation

//MARK:- APIErrors
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
    //MARK: - Protocols
    func request<T: Codable>(router: Router, completion: @escaping (Result<T, APIError>) -> ())
}

class APIService: APIServiceProtocol {
    // MARK: - Private properties
    private var dataTask: URLSessionDataTask?
    private let defaultSession = URLSession(configuration: .default)
}

extension APIService {
    // MARK: - Public methods
    func request<T: Codable>(router: Router, completion: @escaping (Result<T, APIError>) -> ()) {
        
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
        urlRequest.httpBody = router.body
        
        dataTask = defaultSession.dataTask(with: urlRequest) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.requestFailed))
                return
            }
            
            if httpResponse.statusCode >= 200 || httpResponse.statusCode < 299 {
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

extension APIService {
    private static func getData(url: URL,
                         completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
        
    public static func downloadImage(url: URL,
                       completion: @escaping (Result<Data, Error>) -> Void) {
        getData(url: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async() {
                completion(.success(data))
            }
        }
    }
}
