//
//  LoginViewModel.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 17/12/2024.
//

import Combine
import Foundation

class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""

    @Published var error: String = ""
    @Published var isLoading: Bool = false
    @Published var isLoginSuccess: Bool = false

    var loginTapped: PassthroughSubject<Void, Never> = .init()

    private let loginUseCase: LoginUseCaseProtocol
    private let saveSessionUseCase: SaveSessionUseCaseProtocol
    private var cancellables: Set<AnyCancellable> = []

    init(
        username: String? = "",
        password: String? = "",
        loginUseCase: LoginUseCaseProtocol = LoginUseCase(),
        saveSessionUseCase: SaveSessionUseCaseProtocol = SaveSessionUseCase()
    ) {
        self.loginUseCase = loginUseCase
        self.saveSessionUseCase = saveSessionUseCase
        
        self.username = username ?? ""
        self.password = password ?? ""

        setupObservers()
    }

    func setupObservers() {
        loginTapped
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                login()
            }
            .store(in: &cancellables)
    }
    
    private func login() {
        guard !username.isEmpty, !password.isEmpty else {
            error = "Please fill all fields"
            return
        }

        isLoading = true
        
        loginUseCase.execute(username: username, password: password) { result in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                guard let self else { return }
                isLoading = false
                error = ""

                switch result {
                case .success(let loginModel):
                    if let accessToken = loginModel.accessToken, !accessToken.isEmpty {
                        isLoginSuccess = true
                        saveSessionUseCase.execute(accessToken: accessToken)
                    }
                case .failure(let failure):
                    error = failure.localizedDescription
                }
            }
        }
    }
}
