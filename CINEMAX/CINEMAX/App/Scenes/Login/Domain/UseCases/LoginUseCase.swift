//
//  LoginUseCase.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 17/12/2024.
//

import Foundation

protocol LoginUseCaseProtocol {
    func execute(
        username: String,
        password: String,
        completion: @escaping (Result<LoginResponse, NetworkError>) -> Void
    )
}

final class LoginUseCase: LoginUseCaseProtocol {
    private let authRepo: AuthRepoProtocol

    init(authRepo: AuthRepoProtocol = AuthRepo()) {
        self.authRepo = authRepo
    }

    func execute(
        username: String,
        password: String,
        completion: @escaping (Result<LoginResponse, NetworkError>) -> Void
    ) {
        authRepo.login(userName: username, password: password, completion: completion)
    }
}
