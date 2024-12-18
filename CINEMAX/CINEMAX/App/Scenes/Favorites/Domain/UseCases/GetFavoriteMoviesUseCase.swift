//
//  GetFavoriteMoviesUseCase.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 18/12/2024.
//

import Foundation

protocol GetFavoriteMoviesUseCaseProtocol {
    func execute() -> [Movie]
}

struct GetFavoriteMoviesUseCase: GetFavoriteMoviesUseCaseProtocol {
    private let moviesRepo: MoviesRepoProtocol
    
    init(moviesRepo: MoviesRepoProtocol = MoviesRepo()) {
        self.moviesRepo = moviesRepo
    }
    
    func execute() -> [Movie] {
        moviesRepo.fetchFavoriteMovies()
    }
}
