//
//  SearchActorsUseCase.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 16/12/2024.
//

import Foundation
import Combine

protocol SearchActorsUseCaseProtocol {
    func execute(
        actorName: String
    ) -> AnyPublisher<ActorsListResponse, NetworkError>
}

struct SearchActorsUseCase: SearchActorsUseCaseProtocol {
    private let moviesRepo: MoviesRepoProtocol

    init(moviesRepo: MoviesRepoProtocol = MoviesRepo()) {
        self.moviesRepo = moviesRepo
    }

    func execute(
        actorName: String
    ) -> AnyPublisher<ActorsListResponse, NetworkError> {
        moviesRepo.searchActor(actorName: actorName)
    }
}
