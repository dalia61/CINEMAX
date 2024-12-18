//
//  HomeView.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 03/12/2024.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    @State private var isMoviesListViewPresented = false
    @State private var isMoviesDetailsViewPresented = false
    @State private var selectedMovieID: Int?
    
    @State private var isActorsListViewPresented = false
    @State private var isActorDetailsViewPresented = false
    @State private var selectedActorID: Int?
    
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
                    .padding(.top, 8)
            }
        }
    }
    
    private func makeMostPopularMoviesView() -> some View {
        Group {
            switch viewModel.mostPopularViewState {
            case .loading:
                ProgressView()
                    .tint(.white)
            case .empty, .failed:
                EmptyView()
            case .loaded:
                SectionHeaderView(title: "Most popular", buttonTitle: "See All") {
                    isMoviesListViewPresented = true
                }
                .padding(.top, 8)
                
                MoviesSectionView(
                    movies: viewModel.mostPopularMovies,
                    onMovieSelected: { movie in
                        selectedMovieID = movie.id
                        isMoviesDetailsViewPresented = true
                    }, onMovieFavorite: { index in
                        viewModel.favoriteTapped.send(index)
                    }
                )
                .padding(.top, 8)
                
                NavigationLink(
                    destination: MoviesListView(viewModel: MoviesListViewModel()),
                    isActive: $isMoviesListViewPresented
                ) {
                    EmptyView()
                }
                
                NavigationLink(
                    destination: MovieDetailsView(viewModel: MovieDetailsViewModel(movieID: selectedMovieID ?? 0)),
                    isActive: $isMoviesDetailsViewPresented
                ) {
                    EmptyView()
                }

                NavigationLink(
                    destination: SignUpView(viewModel: SignUpViewModel()),
                    isActive: $viewModel.showSignUp
                ) {
                    EmptyView()
                }
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
                    isActorsListViewPresented = true
                }
                .padding(.top, 8)
                
                ActorSectionView(
                    actors: viewModel.actors,
                    onActorSelected: { actor in
                        selectedActorID = actor.id
                        isActorDetailsViewPresented = true
                    }
                )
                .padding(.top, 8)
                
                NavigationLink(
                    destination: ActorListView(viewModel: ActorListViewModel()),
                    isActive: $isActorsListViewPresented
                ) {
                    EmptyView()
                }
                
                NavigationLink(
                    destination: ActorDetailsView(viewModel: ActorDetailsViewModel(actorID: selectedActorID ?? 0)),
                    isActive: $isActorDetailsViewPresented
                ) {
                    EmptyView()
                }
            }
        }
    }
}
