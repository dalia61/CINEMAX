//
//  ActorsListResponse.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 13/12/2024.
//

import Foundation

// MARK: - ActorsListResponse
struct ActorsListResponse: Codable {
    let page: Int
    let results: [MovieCast]?
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct MovieCast: Codable, Identifiable {
    let adult: Bool?
    let gender, id: Int?
    let knownForDepartment: String?
    let name, originalName: String?
    let popularity: Double?
    let profilePath: String?
    let knownFor: [KnownFor]?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case knownFor = "known_for"
    }
}

// MARK: - KnownFor
struct KnownFor: Codable, Identifiable {
    let id: Int
    let originCountry: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case originCountry = "origin_country"
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
    case tv = "tv"
}

enum OriginalLanguage: String, Codable {
    case cn = "cn"
    case en = "en"
    case ja = "ja"
    case nl = "nl"
    case tl = "tl"
    case zh = "zh"
}
