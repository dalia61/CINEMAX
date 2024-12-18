//
//  RemoveSessionUseCase.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 17/12/2024.
//

import Foundation

protocol RemoveSessionUseCaseProtocol {
    func execute()
}

struct RemoveSessionUseCase: RemoveSessionUseCaseProtocol {
    private let authRepo: AuthRepoProtocol

    init(authRepo: AuthRepoProtocol = AuthRepo()) {
        self.authRepo = authRepo
    }

    func execute() {
        authRepo.removeSession()
    }
}
