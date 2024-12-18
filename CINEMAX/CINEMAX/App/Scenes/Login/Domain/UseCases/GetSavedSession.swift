//
//  GetSavedSession.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 17/12/2024.
//

import Foundation

protocol GetSessionUseCaseProtocol {
    func execute() -> String?
}

struct GetSessionUseCase: GetSessionUseCaseProtocol {
    private let authRepo: AuthRepoProtocol

    init(authRepo: AuthRepoProtocol = AuthRepo()) {
        self.authRepo = authRepo
    }

    func execute() -> String? {
        authRepo.getAccessToken()
    }
}
