//
//  Endpoint.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 03/12/2024.
//

import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var requestURL: URL { get }
    var headers: [String: String] { get }
    var parameters: [String: Any]? { get }
    var method: HTTPMethod { get }
    var body: Data? { get }
    //var body: [String: Any]? { get }
}

extension Endpoint {
    var requestURL: URL { URL(string: baseURL + path)! }
    
    var headers: [String: String] {
        return [
            "Authorization": "Bearer \(Constants.bearerToken)",
            "Content-Type": "application/json"
        ]
    }
    //    var headers: [String: String] {
    //        return [
    //            "ApiKey": "\(Constants.APIToken)"
    //        ]
    //    }
    var body: Data? {
        guard let parameters = parameters else { return nil }
        return try? JSONSerialization.data(withJSONObject: parameters, options: [])
    }
}
