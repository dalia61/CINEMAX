//
//  SearchActorsUseCase.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 16/12/2024.
//

import Foundation

protocol SearchActorsUseCaseProtocol {
    func execute(
        actorName: String,
        completion: @escaping (Result<ActorsListResponse, NetworkError>) -> Void
    )
}

struct SearchActorsUseCase: SearchActorsUseCaseProtocol {
    private let moviesRepo: MoviesRepoProtocol

    init(moviesRepo: MoviesRepoProtocol = MoviesRepo()) {
        self.moviesRepo = moviesRepo
    }

    func execute(
        actorName: String,
        completion: @escaping (Result<ActorsListResponse, NetworkError>) -> Void
    ) {
        moviesRepo.searchActor(actorName: actorName, completion: completion)
    }
}
