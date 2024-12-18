//
//  IsMovieFavorieUseCase.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 18/12/2024.
//

import Foundation

protocol IsMovieFavorieUseCaseProtocol {
    func execute(movieId: Int) -> Bool
}

struct IsMovieFavorieUseCase: IsMovieFavorieUseCaseProtocol {
    private let moviesRepo: MoviesRepoProtocol
    
    init(moviesRepo: MoviesRepoProtocol = MoviesRepo()) {
        self.moviesRepo = moviesRepo
    }
    
    func execute(movieId: Int) -> Bool {
        moviesRepo.isMovieFavorite(movieId: movieId)
    }
}
