//
//  GetRelatedMoviesUseCase.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 13/12/2024.
//

import Foundation
import Combine

protocol GetRelatedMoviesUseCaseProtocol {
    func execute(
        movieId: Int
    ) -> AnyPublisher<MoviesListResponse, NetworkError>

}

struct GetRelatedMoviesUseCase: GetRelatedMoviesUseCaseProtocol {
    private let moviesRepo: MoviesRepoProtocol
    
    init(moviesRepo: MoviesRepoProtocol = MoviesRepo()) {
        self.moviesRepo = moviesRepo
    }
    
    func execute(
        movieId: Int
    ) -> AnyPublisher<MoviesListResponse, NetworkError> {
        moviesRepo.fetchRelatedMovies(movieID: movieId)
    }
}
