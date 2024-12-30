//
//  AuthDataSourceProtocol.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 18/12/2024.
//

import Combine

protocol AuthDataSourceProtocol {
    func signup(userName: String, firstName: String, lastName: String, email: String, password: String) -> AnyPublisher<SignUpResponse, NetworkError>
    func login(userName: String, password: String) -> AnyPublisher<LoginResponse, NetworkError>
    func saveSession(accessToken: String)
    func getAccessToken() -> String?
    func removeSession()
}

