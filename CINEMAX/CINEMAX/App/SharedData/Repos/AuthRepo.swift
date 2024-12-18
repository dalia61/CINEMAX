//
//  AuthRepo.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 18/12/2024.
//

import Foundation

struct AuthRepo: AuthRepoProtocol {
    let authDataSource: AuthDataSourceProtocol
    
    init(
        authDataSource: AuthDataSourceProtocol = AuthDataSource()
    ) {
        self.authDataSource = authDataSource
    }
    
    func signup(userName: String, firstName: String, lastName: String, email: String, password: String, completion: @escaping (Result<SignUpResponse, NetworkError>) -> Void) {
        authDataSource.signup(userName: userName, firstName: firstName, lastName: lastName, email: email, password: password, completion: completion)
    }
    
    func login(userName: String, password: String, completion: @escaping (Result<LoginResponse, NetworkError>) -> Void) {
        authDataSource.login(userName: userName, password: password, completion: completion)
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
