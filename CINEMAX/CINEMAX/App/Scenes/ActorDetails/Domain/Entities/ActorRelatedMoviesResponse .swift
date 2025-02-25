//
//  ActorRelatedMoviesResponse .swift
//  CINEMAX
//
//  Created by Dalia Hamada on 17/12/2024.
//

import Foundation

// MARK: - ActorRelatedMoviesResponse
struct ActorRelatedMoviesResponse: Codable {
    let cast: [Cast]?
    let id: Int?
}

// MARK: - Cast
struct Cast: Codable, Identifiable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    var primaryGenre: String {
        genreIDS?.compactMap { genres[$0] }.first ?? ""
    }
    let id: Int?
    let originalLanguage: OriginalLanguage?
    let originalTitle, overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    let character, creditID: String?
    let order: Int?
    var isFavorite: Bool = false

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case character
        case creditID = "credit_id"
        case order
    }
}
