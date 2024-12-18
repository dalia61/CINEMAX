//
//  MoviesEndpoint.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 12/12/2024.
//

import Foundation

enum MoviesEndpoint: Endpoint {
    case signup(username: String, firstName: String, lastName: String, email: String, password: String)
    case login(username: String, password: String)
    case mostPopular
    case upcoming
    case allActors
    case actordetails(actorID: Int)
    case movieDetails(movieID: Int)
    case movieCast(movieID: Int)
    case relatedMovies(movieID: Int)
    case ActorRelatedMovies(actorID: Int)
    case searchMovies(movieName: String)
    case searchActors(actorName: String)

    var path: String {
        switch self {
        case .signup:
            "signingup/v1"
        case .login:
            "accessingApi/v1"
        case .mostPopular:
            "movie/popular?page=1"
        case .upcoming:
            "movie/upcoming?page=1"
        case .allActors:
            "person/popular?page=1"
        case let .actordetails(actorID):
            "person/\(actorID)"
        case let .movieDetails(movieID):
            "movie/\(movieID)"
        case let .movieCast(movieID):
            "movie/\(movieID)/credits"
        case let .relatedMovies(movieID):
            "movie/\(movieID)/similar"
        case let .ActorRelatedMovies(actorID):
            "person/\(actorID)/movie_credits"
        case let .searchMovies(movieName):
            "search/movie?query=\(movieName)"
        case let .searchActors(actorName):
            "search/person?query=\(actorName)"
        }
    }
    
    var baseURL: String {
        switch self {
//        case .signup, .login:
//            Constants.authBaseURL
        default:
            Constants.tmdbBaseURL
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        default: nil
        }
    }
    
    var body: [String : Any]?{
        switch self {
        case let .signup(username, firstName, lastName, email, password):
            [
                "username": username,
                "firstName": firstName,
                "lastName": lastName,
                "email": email,
                "password": password,
            ]
        case let .login(username, password):
            [
                "username": username,
                "password": password,
            ]
        default: nil
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .mostPopular, .upcoming, .allActors, .movieDetails, .movieCast, .relatedMovies, .ActorRelatedMovies, .searchMovies, .searchActors, .actordetails:
                .get
        case .signup, .login:
                .post
        }
    }
}
