//
//  GetMoviesListUseCase.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 12/12/2024.
//

import Foundation
import Combine

protocol GetUpcomingMoviesUseCaseProtocol {
    func execute() -> AnyPublisher<MoviesListResponse, NetworkError>

}

struct GetUpcomingMoviesUseCase: GetUpcomingMoviesUseCaseProtocol {
    private let moviesRepo: MoviesRepoProtocol

    init(moviesRepo: MoviesRepoProtocol = MoviesRepo()) {
        self.moviesRepo = moviesRepo
    }

    func execute() -> AnyPublisher<MoviesListResponse, NetworkError> {
        moviesRepo.fetchUpcoming()
    }
}
