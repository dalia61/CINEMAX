//
//  GetMostPopluarMoviesUseCase.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 13/12/2024.
//

import Foundation
import Combine

protocol GetMostPopularMoviesUseCaseProtocol {
    func execute() -> AnyPublisher<MoviesListResponse, NetworkError>
}

struct GetMostPopularMoviesUseCase: GetMostPopularMoviesUseCaseProtocol {
    private let moviesRepo: MoviesRepoProtocol

    init(moviesRepo: MoviesRepoProtocol = MoviesRepo()) {
        self.moviesRepo = moviesRepo
    }

    func execute() -> AnyPublisher<MoviesListResponse, NetworkError> {
        moviesRepo.fetchMostPopular()
    }
}
