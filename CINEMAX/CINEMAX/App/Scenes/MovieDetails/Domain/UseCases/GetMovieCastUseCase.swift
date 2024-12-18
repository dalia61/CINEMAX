//
//  GetMovieCastUseCase.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 13/12/2024.
//

import Foundation

protocol GetMovieCastUseCaseProtocol {
    func execute(
        movieId: Int,
        completion: @escaping (Result<MovieCastResponse, NetworkError>) -> Void
    )
}

struct GetMovieCastUseCase: GetMovieCastUseCaseProtocol {
    private let moviesRepo: MoviesRepoProtocol
    
    init(moviesRepo: MoviesRepoProtocol = MoviesRepo()) {
        self.moviesRepo = moviesRepo
    }
    
    func execute(
        movieId: Int,
        completion: @escaping (Result<MovieCastResponse, NetworkError>) -> Void
    ) {
        moviesRepo.fetchMovieCast(movieID: movieId, completion: completion)
    }
}
