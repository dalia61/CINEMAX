//
//  GetActorDetailsUseCase.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 16/12/2024.
//

import Foundation

protocol GetActorDetailsUseCaseProtocol {
    func execute(
        actorId: Int,
        completion: @escaping (Result<ActorDetails, NetworkError>) -> Void
    )
}

struct GetActorDetailsUseCase: GetActorDetailsUseCaseProtocol {
    private let actorRepo: MoviesRepoProtocol
    
    init(moviesRepo: MoviesRepoProtocol = MoviesRepo()) {
        self.actorRepo = moviesRepo
    }
    
    func execute(actorId: Int, completion: @escaping (Result<ActorDetails, NetworkError>) -> Void) {
        actorRepo.fetchActorDetails(actorID: actorId, completion: completion)
    }
}
