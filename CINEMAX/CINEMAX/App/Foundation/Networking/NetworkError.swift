//
//  NetworkError.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 03/12/2024.
//

import Foundation

struct ResponseError: Error, Decodable {
    let message: String
}

enum NetworkError: Error {
    case forbidden
    case unauthorized
    case notFound
    case serverError
    case somethingWentWrong
    case custom(ResponseError)
    case badResponse
    case decodingError
}

extension NetworkError {
    var localizedDescription: String {
        switch self {
        case .forbidden:
            return "Forbidden: You don't have permission to access this resource."
        case .unauthorized:
            return "Unauthorized: Please check your credentials."
        case .notFound:
            return "Resource not found."
        case .serverError:
            return "Server error, please try again later."
        case .somethingWentWrong:
            return "Something went wrong, please try again later."
        case .badResponse:
            return "Received an invalid response from the server."
        case .decodingError:
            return "Failed to decode the response from the server."
        case let .custom(response):
            return response.message
        }
    }
}
