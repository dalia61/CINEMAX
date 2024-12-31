//
//  RemoveFromFavoritesUseCase.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 18/12/2024.
//

import Foundation

protocol RemoveMovieFromFavoritesUseCaseProtocol {
    func execute(movieId: Int)
}

protocol RemoveMovieCastFromFavoritesUseCaseProtocol {
    func execute(movieId: Int)
}

struct RemoveMovieFromFavoritesUseCase: RemoveMovieFromFavoritesUseCaseProtocol {
    private let moviesRepo: MoviesRepoProtocol
    
    init(moviesRepo: MoviesRepoProtocol = MoviesRepo()) {
        self.moviesRepo = moviesRepo
    }
    
    func execute(movieId: Int) {
        moviesRepo.removeMovieFromFavorites(movieId: movieId)
    }
}

struct RemoveMovieCastFromFavoritesUseCase: RemoveMovieCastFromFavoritesUseCaseProtocol {
    private let moviesRepo: MoviesRepoProtocol
    
    init(moviesRepo: MoviesRepoProtocol = MoviesRepo()) {
        self.moviesRepo = moviesRepo
    }
    
    func execute(movieId: Int) {
        moviesRepo.removeMovieCastFromFavorites(movieId: movieId)
    }
}
