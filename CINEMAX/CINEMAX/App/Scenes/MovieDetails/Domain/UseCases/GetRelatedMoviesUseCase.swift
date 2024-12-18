//
//  GetRelatedMoviesUseCase.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 13/12/2024.
//

import Foundation

protocol GetRelatedMoviesUseCaseProtocol {
    func execute(
        movieId: Int,
        completion: @escaping (Result<MoviesListResponse, NetworkError>) -> Void
    )
}

struct GetRelatedMoviesUseCase: GetRelatedMoviesUseCaseProtocol {
    private let moviesRepo: MoviesRepoProtocol
    
    init(moviesRepo: MoviesRepoProtocol = MoviesRepo()) {
        self.moviesRepo = moviesRepo
    }
    
    func execute(
        movieId: Int,
        completion: @escaping (Result<MoviesListResponse, NetworkError>) -> Void
    ) {
        moviesRepo.fetchRelatedMovies(movieID: movieId, completion: completion)
    }
}
