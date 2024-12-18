//
//  GetActorRelatedMoviesUseCase.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 16/12/2024.
//

import Foundation

protocol GetActorRelatedMoviesUseCaseProtocol {
    func execute(
        actorId: Int,
        completion: @escaping (Result<ActorRelatedMoviesResponse, NetworkError>) -> Void
    )
}

struct GetActorRelatedMoviesUseCase: GetActorRelatedMoviesUseCaseProtocol {
    private let moviesRepo: MoviesRepoProtocol
    
    init(moviesRepo: MoviesRepoProtocol = MoviesRepo()) {
        self.moviesRepo = moviesRepo
    }

    func execute(actorId: Int, completion: @escaping (Result<ActorRelatedMoviesResponse, NetworkError>) -> Void) {
        moviesRepo.fetchActorRelatedMovies(actorID: actorId, completion: completion)
    }
    
}
