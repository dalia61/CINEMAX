//
//  MoviesListResponse.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 12/12/2024.
//

import Foundation

// MARK: - MoviesListResponse
struct MoviesListResponse: Codable {
    let dates: Dates?
    let page: Int?
    let results: [Movie]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Dates
struct Dates: Codable {
    let maximum, minimum: String?
}

// MARK: - Result
struct Movie: Codable, Identifiable {
    let adult: Bool?
    let backdropPath: String?
    let genreIds: [Int]?
    var genresString: String {
        genreIds?.compactMap { genres[$0] }.joined(separator: " | ") ?? ""
    }
    var primaryGenre: String {
        genreIds?.compactMap { genres[$0] }.first ?? ""
    }
    let id: Int?
    let originalLanguage: String?
    var language: String {
        languages[originalLanguage ?? ""] ?? "Unknown"
    }
    let originalTitle, overview: String?
    let popularity: Double?
    let posterPath, releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    var isFavorite: Bool = false

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

let genres: [Int: String] = [
    28: "Action",
    12: "Adventure",
    16: "Animation",
    35: "Comedy",
    80: "Crime",
    99: "Documentary",
    18: "Drama",
    10751: "Family",
    14: "Fantasy",
    36: "History",
    27: "Horror",
    10402: "Music",
    10749: "Romance",
    878: "Science Fiction",
    53: "Thriller",
    10752: "War",
    37: "Western",
    10755: "Action & Adventure",
    10756: "Crime & Thriller",
    10757: "Science Fiction & Fantasy"
]

let languages: [String: String] = [
    "en": "English",
    "es": "Spanish",
    "fr": "French",
    "de": "German",
    "it": "Italian",
    "pt": "Portuguese",
    "ru": "Russian",
    "ja": "Japanese",
    "ko": "Korean",
    "zh": "Chinese (Simplified)",
    "ar": "Arabic",
    "hi": "Hindi",
    "sv": "Swedish",
    "no": "Norwegian",
    "da": "Danish",
    "fi": "Finnish",
    "nl": "Dutch",
    "pl": "Polish",
    "tr": "Turkish",
    "cs": "Czech",
    "ro": "Romanian",
    "el": "Greek",
    "th": "Thai",
    "he": "Hebrew",
    "id": "Indonesian",
    "vi": "Vietnamese",
    "tl": "Tagalog",
    "sr": "Serbian",
    "hu": "Hungarian",
    "sk": "Slovak",
    "bg": "Bulgarian",
    "hr": "Croatian",
    "ms": "Malay",
    "ka": "Georgian",
    "is": "Icelandic",
    "mk": "Macedonian",
    "et": "Estonian",
    "lv": "Latvian",
    "lt": "Lithuanian",
    "sl": "Slovenian"
]
