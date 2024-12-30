//
//  LoginUseCase.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 17/12/2024.
//

import Foundation
import Combine

protocol LoginUseCaseProtocol {
    func execute(
        username: String,
        password: String
    ) -> AnyPublisher<LoginResponse, NetworkError>
}

final class LoginUseCase: LoginUseCaseProtocol {
    private let authRepo: AuthRepoProtocol

    init(authRepo: AuthRepoProtocol = AuthRepo()) {
        self.authRepo = authRepo
    }

    func execute(
        username: String,
        password: String
    ) -> AnyPublisher<LoginResponse, NetworkError> {
        authRepo.login(userName: username, password: password)
    }
}
