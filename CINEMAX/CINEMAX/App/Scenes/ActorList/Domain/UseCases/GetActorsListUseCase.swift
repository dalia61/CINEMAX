//
//  GetActorsListUseCase.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 14/12/2024.
//

import Foundation
import Combine

protocol GetActorsListUseCaseProtocol {
    func execute(
    ) -> AnyPublisher<ActorsListResponse, NetworkError>
}

final class GetActorsListUseCase: GetActorsListUseCaseProtocol {
    private let moviesRepo: MoviesRepoProtocol

    init(moviesRepo: MoviesRepoProtocol = MoviesRepo()) {
        self.moviesRepo = moviesRepo
    }

    func execute() -> AnyPublisher<ActorsListResponse, NetworkError> {
        moviesRepo.fetchAllActors()
    }
}
