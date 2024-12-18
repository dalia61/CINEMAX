//
//  CINEMAXApp.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 03/12/2024.
//

import SwiftUI

@main
struct CINEMAXApp: App {
    let getSessionUseCase: GetSessionUseCaseProtocol = GetSessionUseCase()

    var body: some Scene {
        WindowGroup {
            if let accessToken = getSessionUseCase.execute(), !accessToken.isEmpty {
                TabBarView()
            } else {
                SignUpView(viewModel: SignUpViewModel())
            }
        }
    }
}
