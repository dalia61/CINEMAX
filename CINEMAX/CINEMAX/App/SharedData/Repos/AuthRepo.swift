//
//  AuthRepo.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 18/12/2024.
//

import Foundation
import Combine

struct AuthRepo: AuthRepoProtocol {
    let authDataSource: AuthDataSourceProtocol
    
    init(
        authDataSource: AuthDataSourceProtocol = AuthDataSource()
    ) {
        self.authDataSource = authDataSource
    }
    
    func signup(userName: String, firstName: String, lastName: String, email: String, password: String) -> AnyPublisher<SignUpResponse, NetworkError> {
        authDataSource.signup(userName: userName, firstName: firstName, lastName: lastName, email: email, password: password)
    }
    
    func login(userName: String, password: String) -> AnyPublisher<LoginResponse, NetworkError> {
        //        authDataSource.login(userName: userName, password: password)
        return Just(LoginResponse(accessToken: "test"))
            .mapError { _ in NetworkError.badResponse } // Convert Never to NetworkError
            .eraseToAnyPublisher()
    }
    
    func saveSession(accessToken: String) {
        authDataSource.saveSession(accessToken: accessToken)
    }
    
    func getAccessToken() -> String? {
        authDataSource.getAccessToken()
    }
    
    func removeSession() {
        authDataSource.removeSession()
    }
}
