//
//  SignUpUseCase.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 17/12/2024.
//

import Foundation
import Combine

protocol SignUpUseCaseProtocol {
    func execute(
        username: String,
        firstName: String,
        lastName: String,
        email: String,
        password: String
    ) -> AnyPublisher<SignUpResponse, NetworkError>

}

final class SignUpUseCase: SignUpUseCaseProtocol {
    private let authRepo: AuthRepoProtocol

    init(authRepo: AuthRepoProtocol = AuthRepo()) {
        self.authRepo = authRepo
    }

    func execute(
        username: String,
        firstName: String,
        lastName: String,
        email: String,
        password: String
    ) -> AnyPublisher<SignUpResponse, NetworkError> {
        authRepo.signup(userName: username, firstName: firstName, lastName: lastName, email: email, password: password)
    }
}
