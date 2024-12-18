//
//  AuthDataSource.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 18/12/2024.
//

import Foundation
import KeychainSwift

struct AuthDataSource: AuthDataSourceProtocol {
    private let networkingManger: NetworkManagerProtocol
    private let keychain = KeychainSwift()

    public init(networkingManger: NetworkManagerProtocol = NetworkManager()) {
        self.networkingManger = networkingManger
    }
    
    func signup(userName: String, firstName: String, lastName: String, email: String, password: String, completion: @escaping (Result<SignUpResponse, NetworkError>) -> Void) {
        let endpoint = MoviesEndpoint.signup(username: userName, firstName: firstName, lastName: lastName, email: email, password: password)
        networkingManger.request(
            using: endpoint,
            completion: completion
        )
    }
    
    func login(userName: String, password: String, completion: @escaping (Result<LoginResponse, NetworkError>) -> Void) {
        let endpoint = MoviesEndpoint.login(username: userName, password: password)
        networkingManger.request(
            using: endpoint,
            completion: completion
        )
    }
    
    func saveSession(accessToken: String) {
        keychain.set(accessToken, forKey: Constants.accessTokenKey)
    }
    
    func getAccessToken() -> String? {
        return keychain.get(Constants.accessTokenKey)
    }
    
    func removeSession() {
        keychain.delete(Constants.accessTokenKey)
    }
}
