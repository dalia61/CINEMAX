//
//  RemoveFromFavoritesUseCase.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 18/12/2024.
//

import Foundation

protocol RemoveFromFavoritesUseCaseProtocol {
    func execute(movieId: Int)
}

struct RemoveFromFavoritesUseCase: RemoveFromFavoritesUseCaseProtocol {
    private let moviesRepo: MoviesRepoProtocol
    
    init(moviesRepo: MoviesRepoProtocol = MoviesRepo()) {
        self.moviesRepo = moviesRepo
    }
    
    func execute(movieId: Int) {
        moviesRepo.removeFromFavorites(movieId: movieId)
    }
}
