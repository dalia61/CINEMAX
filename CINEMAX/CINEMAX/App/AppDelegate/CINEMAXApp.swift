//
//  CINEMAXApp.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 03/12/2024.
//

import SwiftUI

@main
struct CINEMAXApp: App {
    @ObservedObject var router = Router()

    let getSessionUseCase: GetSessionUseCaseProtocol = GetSessionUseCase()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                Group {
                    if let accessToken = getSessionUseCase.execute(), !accessToken.isEmpty {
                        TabBarView()
                    } else {
                        SignUpView(viewModel: SignUpViewModel())
                    }
                }
                .navigationDestination(for: Router.Destination.self) { destination in
                    switch destination {
                    case let .login(username, password):
                        LoginView(viewModel: LoginViewModel(username: username, password: password))
                    case .signup:
                        SignUpView(viewModel: SignUpViewModel())
                    case .tabBar:
                        TabBarView()
                    case .moviesList:
                        MoviesListView(viewModel: MoviesListViewModel())
                    case let .movieDetails(movieID):
                        MovieDetailsView(viewModel: MovieDetailsViewModel(movieID: movieID))
                    case .actorsList:
                        ActorListView(viewModel: ActorListViewModel())
                    case let .actorDetails(actorID):
                        ActorDetailsView(viewModel: ActorDetailsViewModel(actorID: actorID))
                    }
                }
            }
            .environmentObject(router)
        }
    }
}
