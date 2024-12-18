//
//  GetMostPopluarMoviesUseCase.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 13/12/2024.
//

import Foundation

protocol GetMostPopularMoviesUseCaseProtocol {
    func execute(completion: @escaping (Result<MoviesListResponse, NetworkError>) -> Void)
}

struct GetMostPopularMoviesUseCase: GetMostPopularMoviesUseCaseProtocol {
    private let moviesRepo: MoviesRepoProtocol

    init(moviesRepo: MoviesRepoProtocol = MoviesRepo()) {
        self.moviesRepo = moviesRepo
    }

    func execute(completion: @escaping (Result<MoviesListResponse, NetworkError>) -> Void) {
        moviesRepo.fetchMostPopular(completion: completion)
    }
}
