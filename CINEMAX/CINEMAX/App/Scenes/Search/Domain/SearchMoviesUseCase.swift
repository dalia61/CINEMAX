//
//  SearchMoviesUseCase.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 12/12/2024.
//

import Foundation
import Combine

protocol SearchMoviesUseCaseProtocol {
    func execute(
        movieName: String
    ) -> AnyPublisher<MoviesListResponse, NetworkError>
}

struct SearchMoviesUseCase: SearchMoviesUseCaseProtocol {
    private let moviesRepo: MoviesRepoProtocol

    init(moviesRepo: MoviesRepoProtocol = MoviesRepo()) {
        self.moviesRepo = moviesRepo
    }

    func execute(
        movieName: String
    ) -> AnyPublisher<MoviesListResponse, NetworkError> {
        moviesRepo.searchMovie(movieName: movieName)
    }
}
