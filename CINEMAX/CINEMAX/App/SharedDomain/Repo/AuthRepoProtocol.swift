//
//  AuthRepoProtocol.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 18/12/2024.
//

import Foundation

protocol AuthRepoProtocol {
    func signup(userName: String, firstName: String, lastName: String, email: String, password: String, completion: @escaping (Result<SignUpResponse, NetworkError>) -> Void)
    func login(userName: String, password: String, completion: @escaping (Result<LoginResponse, NetworkError>) -> Void)
    func saveSession(accessToken: String)
    func getAccessToken() -> String?
    func removeSession()
}
