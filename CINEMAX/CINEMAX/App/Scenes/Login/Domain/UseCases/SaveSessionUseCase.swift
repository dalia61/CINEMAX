//
//  SaveSessionUseCase.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 17/12/2024.
//

import Foundation
import KeychainSwift

protocol SaveSessionUseCaseProtocol {
    func execute(accessToken: String)
}

struct SaveSessionUseCase: SaveSessionUseCaseProtocol {
    private let authRepo: AuthRepoProtocol

    init(authRepo: AuthRepoProtocol = AuthRepo()) {
        self.authRepo = authRepo
    }

    func execute(accessToken: String) {
        authRepo.saveSession(accessToken: accessToken)
    }
}
