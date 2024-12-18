//
//  GetMoviesListUseCase.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 12/12/2024.
//

import Foundation

protocol GetUpcomingMoviesUseCaseProtocol {
    func execute(completion: @escaping (Result<MoviesListResponse, NetworkError>) -> Void)
}

struct GetUpcomingMoviesUseCase: GetUpcomingMoviesUseCaseProtocol {
    private let moviesRepo: MoviesRepoProtocol

    init(moviesRepo: MoviesRepoProtocol = MoviesRepo()) {
        self.moviesRepo = moviesRepo
    }

    func execute(completion: @escaping (Result<MoviesListResponse, NetworkError>) -> Void) {
        moviesRepo.fetchUpcoming(completion: completion)
    }
}
