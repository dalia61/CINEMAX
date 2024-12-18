//
//  SearchMoviesUseCase.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 12/12/2024.
//

import Foundation

protocol SearchMoviesUseCaseProtocol {
    func execute(
        movieName: String,
        completion: @escaping (Result<MoviesListResponse, NetworkError>) -> Void
    )
}

struct SearchMoviesUseCase: SearchMoviesUseCaseProtocol {
    private let moviesRepo: MoviesRepoProtocol

    init(moviesRepo: MoviesRepoProtocol = MoviesRepo()) {
        self.moviesRepo = moviesRepo
    }

    func execute(
        movieName: String,
        completion: @escaping (Result<MoviesListResponse, NetworkError>) -> Void
    ) {
        moviesRepo.searchMovie(movieName: movieName, completion: completion)
    }
}
