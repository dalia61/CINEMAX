//
//  HomeView.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 03/12/2024.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    @EnvironmentObject var router: Router

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    makeHeaderView()
                    Divider()

                    makeUpcomingMoviesView()
                        .frame(height: 180)
                    Divider()

                    makeMostPopularMoviesView()
                    Divider()

                    makeActorsView()
                    Divider()
                }
            }
            .padding(16)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.darkAccent)
            .onAppear {
                viewModel.viewAppeared.send()
            }
        }
        .onReceive(viewModel.$showSignUp) { showSignUp in
            if showSignUp {
                router.navigateToRoot()
            }
        }
        .navigationBarHidden(true)
    }

    private func makeHeaderView() -> some View {
        HStack {
            Image(.atosLogo)
                .resizable()
                .frame(width: 40, height: 40)
                .clipShape(Circle())

            VStack(alignment: .leading) {
                Text("Hello, Dalia 👋")
                    .foregroundStyle(.white)
                    .font(.system(size: 16, weight: .semibold))

                Text("Let’s stream your favorite movie.")
                    .foregroundStyle(.gray)
                    .font(.system(size: 12, weight: .medium))
            }

            Spacer()

            Button(action: {
                viewModel.logoutTapped.send()
                router.navigate(to: .signup)
            }) {
                Image(systemName: "iphone.and.arrow.right.inward")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.white)
            }
        }
    }

    private func makeUpcomingMoviesView() -> some View {
        Group {
            switch viewModel.upcomingViewState {
            case .loading:
                ProgressView()
                    .tint(.white)
            case .empty, .failed:
                EmptyView()
            case .loaded:
                MovieCollectionViewWrapper(movies: viewModel.upcomingMovies)
                    .padding([.top,.bottom], 8)
            }
        }
    }

    private func makeMostPopularMoviesView() -> some View {
        VStack {
            switch viewModel.mostPopularViewState {
            case .loading:
                ProgressView()
                    .tint(.white)
            case .empty, .failed:
                EmptyView()
            case .loaded:
                SectionHeaderView(title: "Most popular", buttonTitle: "See All") {
                    router.navigate(to: .moviesList)
                }
                .padding(.top, 8)

                MoviesSectionView(
                    movies: viewModel.mostPopularMovies,
                    onMovieSelected: { movie in
                        router.navigate(to: .movieDetails(movieID: movie.id ?? 0))
                    }, onMovieFavorite: { index in
                        viewModel.favoriteTapped.send(index)
                    }
                )
                .padding(.top, 8)
            }
        }
    }

    private func makeActorsView() -> some View {
        Group {
            switch viewModel.actorsViewState {
            case .loading:
                ProgressView()
                    .tint(.white)
            case .empty, .failed:
                EmptyView()
            case .loaded:
                SectionHeaderView(title: "Popular Actors", buttonTitle: "See All") {
                    router.navigate(to: .actorsList)
                }

                ActorSectionView(
                    actors: viewModel.actors,
                    onActorSelected: { actor in
                        router.navigate(to: .actorDetails(actorID: actor.id ?? 0))
                    }
                )
                .padding(.top, 8)
            }
        }
    }
}
#Preview {
    HomeView(viewModel: HomeViewModel())
}
