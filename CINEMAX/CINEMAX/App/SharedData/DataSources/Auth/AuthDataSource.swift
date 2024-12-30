//
//  AuthDataSource.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 18/12/2024.
//

import Foundation
import KeychainSwift
import Combine

struct AuthDataSource: AuthDataSourceProtocol {
    private let networkingManger: NetworkManagerProtocol
    private let keychain = KeychainSwift()

    public init(networkingManger: NetworkManagerProtocol = NetworkManager()) {
        self.networkingManger = networkingManger
    }
    
    func signup(userName: String, firstName: String, lastName: String, email: String, password: String) -> AnyPublisher<SignUpResponse, NetworkError> {
        let endpoint = MoviesEndpoint.signup(username: userName, firstName: firstName, lastName: lastName, email: email, password: password)
        return networkingManger.request(using: endpoint)
    }
    
    func login(userName: String, password: String) -> AnyPublisher<LoginResponse, NetworkError>  {
        let endpoint = MoviesEndpoint.login(username: userName, password: password)
        return networkingManger.request(using: endpoint)
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
