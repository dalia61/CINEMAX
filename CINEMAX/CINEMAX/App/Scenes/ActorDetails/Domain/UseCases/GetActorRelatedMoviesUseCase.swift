//
//  GetActorRelatedMoviesUseCase.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 16/12/2024.
//

import Combine

protocol GetActorRelatedMoviesUseCaseProtocol {
    func execute(
        actorId: Int
    ) -> AnyPublisher<ActorRelatedMoviesResponse, NetworkError>
}

struct GetActorRelatedMoviesUseCase: GetActorRelatedMoviesUseCaseProtocol {
    private let moviesRepo: MoviesRepoProtocol
    
    init(moviesRepo: MoviesRepoProtocol = MoviesRepo()) {
        self.moviesRepo = moviesRepo
    }

    func execute(actorId: Int) -> AnyPublisher<ActorRelatedMoviesResponse, NetworkError> {
        moviesRepo.fetchActorRelatedMovies(actorID: actorId)
    }
}
