//
//  GetActorDetailsUseCase.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 16/12/2024.
//

import Foundation
import Combine

protocol GetActorDetailsUseCaseProtocol {
    func execute(
        actorId: Int
    ) -> AnyPublisher<ActorDetails, NetworkError>
}

struct GetActorDetailsUseCase: GetActorDetailsUseCaseProtocol {
    private let actorRepo: MoviesRepoProtocol
    
    init(moviesRepo: MoviesRepoProtocol = MoviesRepo()) {
        self.actorRepo = moviesRepo
    }
    
    func execute(actorId: Int) -> AnyPublisher<ActorDetails, NetworkError>{
        actorRepo.fetchActorDetails(actorID: actorId)
    }
}
