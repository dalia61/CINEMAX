//
//  SortMoviesUseCase.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 15/12/2024.
//

import Foundation

protocol SortMoviesUseCaseProtocol {
    func execute(
        movies: [Movie],
        sortBy: SortOption
    ) -> [Movie]
}

struct SortMoviesUseCase: SortMoviesUseCaseProtocol {
    func execute(
        movies: [Movie],
        sortBy: SortOption
    ) -> [Movie] {
        var sortedMovies: [Movie] = movies

        switch sortBy {
        case .popularity:
            sortedMovies = sortByPopularity(movies: movies)
        case .rating:
            sortedMovies = sortBuRating(movies: movies)
        case .releaseDate:
            sortedMovies = sortByReleaseDate(movies: movies)
        }

        return sortedMovies
    }

    private func sortByPopularity(movies: [Movie]) -> [Movie] {
        movies.sorted(by: { movie1, movie2 in
            movie1.popularity ?? 0 > movie2.popularity ?? 0
        })
    }

    private func sortBuRating(movies: [Movie]) -> [Movie] {
        movies.sorted(by: { movie1, movie2 in
            movie1.voteAverage ?? 0 > movie2.voteAverage ?? 0
        })
    }

    private func sortByReleaseDate(movies: [Movie]) -> [Movie] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" 

        return movies.sorted { movie1, movie2 in
            guard let releaseDate1String = movie1.releaseDate,
                  let releaseDate2String = movie2.releaseDate,
                  let releaseDate1 = dateFormatter.date(from: releaseDate1String),
                  let releaseDate2 = dateFormatter.date(from: releaseDate2String) else {
                return false
            }

            return releaseDate1 > releaseDate2
        }
    }
}
