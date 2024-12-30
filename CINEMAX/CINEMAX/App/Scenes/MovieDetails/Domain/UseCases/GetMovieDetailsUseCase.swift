//
//  GetMovieDetailsUseCase.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 13/12/2024.
//

import Foundation
import Combine

protocol GetMovieDetailsUseCaseProtocol {
    func execute(
        movieId: Int
    ) -> AnyPublisher<MovieDetails, NetworkError>
}

struct GetMovieDetailsUseCase: GetMovieDetailsUseCaseProtocol {
    private let moviesRepo: MoviesRepoProtocol
    
    init(moviesRepo: MoviesRepoProtocol = MoviesRepo()) {
        self.moviesRepo = moviesRepo
    }
    
    func execute(
        movieId: Int
    ) -> AnyPublisher<MovieDetails, NetworkError> {
        moviesRepo.fetchMovieDetails(movieID: movieId)
    }
}
