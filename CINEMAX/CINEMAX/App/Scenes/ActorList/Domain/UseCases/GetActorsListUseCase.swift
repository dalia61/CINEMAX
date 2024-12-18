//
//  GetActorsListUseCase.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 14/12/2024.
//

import Foundation

protocol GetActorsListUseCaseProtocol {
    func execute(completion: @escaping (Result<ActorsListResponse, NetworkError>) -> Void)
}

final class GetActorsListUseCase: GetActorsListUseCaseProtocol {
    private let moviesRepo: MoviesRepoProtocol

    init(moviesRepo: MoviesRepoProtocol = MoviesRepo()) {
        self.moviesRepo = moviesRepo
    }

    func execute(completion: @escaping (Result<ActorsListResponse, NetworkError>) -> Void) {
        moviesRepo.fetchAllActors(completion: completion)
    }
}
