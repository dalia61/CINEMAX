//
//  MovieCastResponse.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 14/12/2024.
//

import Foundation

struct MovieCastResponse: Codable {
    let id: Int?
    let cast, crew: [MovieCast]?
}
