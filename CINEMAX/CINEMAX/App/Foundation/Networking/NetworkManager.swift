//
//  NetworkManager.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 03/12/2024.
//

import Foundation

protocol NetworkManagerProtocol: AnyObject {
    func request<T: Codable>(
        using endpoint: Endpoint,
        completion: @escaping (Result<T, NetworkError>) -> Void
    )
}

class NetworkManager: NetworkManagerProtocol {
    
    // Perform network request with URLSession
    func request<T: Decodable>(
        using endpoint: Endpoint,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        var request = URLRequest(url: endpoint.requestURL)
        request.httpMethod = endpoint.method.rawValue
        endpoint.headers.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        
        if let body = endpoint.body {
            request.httpBody = body
            //        if let body = endpoint.body {
            //            do {
            //                let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
            //                request.httpBody = jsonData
            //            }
            //            catch {
            //                return completion(.failure(.badResponse))
            //            }
            //        }
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(self.handleError(error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.badResponse))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        
        task.resume()
    }
    
    private func handleError(_ error: Error) -> NetworkError {
        return .custom(ResponseError(message: error.localizedDescription))
    }
}
