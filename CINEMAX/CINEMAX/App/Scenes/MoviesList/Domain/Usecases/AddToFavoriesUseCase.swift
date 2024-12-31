//
//  AddToFavoriesUseCase.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 18/12/2024.
//

import Foundation

protocol AddToFavoritesUseCaseProtocol {
    func execute(movie: Movie)
    func execute(movieCast: Cast)
}

struct AddToFavoritesUseCase: AddToFavoritesUseCaseProtocol {
    private let moviesRepo: MoviesRepoProtocol
    
    init(moviesRepo: MoviesRepoProtocol = MoviesRepo()) {
        self.moviesRepo = moviesRepo
    }
    
    func execute(movie: Movie) {
        moviesRepo.addToFavorites(movie: movie)
    }
    
    func execute(movieCast: Cast) {
        moviesRepo.addToFavorites(movieCast: movieCast)
    }
}
