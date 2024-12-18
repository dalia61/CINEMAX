//
//  GetMovieDetailsUseCase.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 13/12/2024.
//

import Foundation

protocol GetMovieDetailsUseCaseProtocol {
    func execute(
        movieId: Int,
        completion: @escaping (Result<MovieDetails, NetworkError>) -> Void
    )
}

struct GetMovieDetailsUseCase: GetMovieDetailsUseCaseProtocol {
    private let moviesRepo: MoviesRepoProtocol
    
    init(moviesRepo: MoviesRepoProtocol = MoviesRepo()) {
        self.moviesRepo = moviesRepo
    }
    
    func execute(
        movieId: Int,
        completion: @escaping (Result<MovieDetails, NetworkError>) -> Void
    ) {
        moviesRepo.fetchMovieDetails(movieID: movieId, completion: completion)
    }
}
