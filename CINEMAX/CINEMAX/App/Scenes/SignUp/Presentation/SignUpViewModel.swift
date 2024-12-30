//
//  SignUpViewModel.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 17/12/2024.
//

import Foundation
import Combine

class SignUpViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var error: String = ""
    @Published var isLoading: Bool = false
    @Published var showLogin: Bool = false

    var signUpTapped: PassthroughSubject<Void, Never> = .init()
    var loginTapped: PassthroughSubject<Void, Never> = .init()

    private let signUpUseCase: SignUpUseCaseProtocol
    
    private var cancellables: Set<AnyCancellable> = []

    init(signUpUseCase: SignUpUseCaseProtocol = SignUpUseCase()) {
        self.signUpUseCase = signUpUseCase
        setupObservers()
    }
    
    func setupObservers() {
        signUpTapped
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }

                signUp()
            }
            .store(in: &cancellables)
        
        loginTapped
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }

                showLogin = true
            }
            .store(in: &cancellables)
    }

    private func signUp() {
        guard !username.isEmpty, !firstName.isEmpty, !lastName.isEmpty, !email.isEmpty, !password.isEmpty else {
            error = "Please fill all fields"
            return
        }

        isLoading = true
        
        signUpUseCase.execute(username: username, firstName: firstName, lastName: lastName, email: email, password: password)
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    DispatchQueue.main.async { [weak self] in
                        guard let self else { return }
                        isLoading = false
                        error = "Something went wrong"
                    }
                }
            }, receiveValue: { signUpModel in
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }

                    isLoading = false
                    error = ""

                    if signUpModel.status == "success" {
                        showLogin = true
                    }
                }
            })
            .store(in: &cancellables)
    }
}
