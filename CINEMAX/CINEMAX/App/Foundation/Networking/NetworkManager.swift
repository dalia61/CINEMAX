//
//  NetworkManager.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 03/12/2024.
//

import Foundation
import Combine

protocol NetworkManagerProtocol: AnyObject {
    func request<T: Codable>(using endpoint: Endpoint) -> AnyPublisher<T, NetworkError>
}

class NetworkManager: NetworkManagerProtocol {
    func request<T: Decodable>(using endpoint: Endpoint) -> AnyPublisher<T, NetworkError> {
        var request = URLRequest(url: endpoint.requestURL)
        request.httpMethod = endpoint.method.rawValue
        endpoint.headers.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }

        if let body = endpoint.body {
            request.httpBody = body
//            if let body = endpoint.body {
//                do {
//                    let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
//                    request.httpBody = jsonData
//                } catch {
//                    return completion(.failure(.badResponse))
//                }
//            }
        }

        return Future { promise in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                if let error = error {
                    promise(.failure(self.handleError(error)))
                    return
                }

                guard let data = data else {
                    promise(.failure(.badResponse))
                    return
                }

                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    promise(.success(decodedData))
                } catch {
                    promise(.failure(.decodingError))
                }
            }

            task.resume()
        }
        .eraseToAnyPublisher()
    }

    private func handleError(_ error: Error) -> NetworkError {
        return .custom(ResponseError(message: error.localizedDescription))
    }
}

