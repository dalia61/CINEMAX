//
//  GetMovieCastUseCase.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 13/12/2024.
//

import Foundation
import Combine

protocol GetMovieCastUseCaseProtocol {
    func execute(
        movieId: Int
    ) -> AnyPublisher<MovieCastResponse, NetworkError>
}

struct GetMovieCastUseCase: GetMovieCastUseCaseProtocol {
    private let moviesRepo: MoviesRepoProtocol
    
    init(moviesRepo: MoviesRepoProtocol = MoviesRepo()) {
        self.moviesRepo = moviesRepo
    }
    
    func execute(
        movieId: Int
    ) -> AnyPublisher<MovieCastResponse, NetworkError>
    {
        moviesRepo.fetchMovieCast(movieID: movieId)
    }
}
