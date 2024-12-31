//
//  SearchView.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 03/12/2024.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: SearchViewModel
    @EnvironmentObject var router: Router

    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBarView(text: $viewModel.searchText)
    
                ScrollView (.vertical, showsIndicators: false) {
                    switch viewModel.moviesState {
                    case .loading:
                        makeLoadingView()
                        
                    case .empty:
                        makeEmptyView()
                        
                    case .failed:
                        makeFailureView()
                        
                    case .loaded:
                        VStack {
                            makeActorListView()
                            makeMoviesListView()
                        }
                    }
                    Spacer()
                }
            }
            .padding(16)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.darkAccent)
            .onAppear {
                viewModel.viewAppeared.send()
            }
        }
    }
    
    private func makeLoadingView() -> some View {
        ProgressView()
            .tint(.white)
    }
    
    private func makeEmptyView() -> some View {
        EmptyStateView()
    }
    
    private func makeFailureView() -> some View {
        VStack {
            Text("Something went wrong, Try again later!")
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
    
    private func makeMoviesListView() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            SectionHeaderView(title: "Movies")
                .padding(.top, 8)
            LazyVStack(spacing: 16) {
                ForEach(viewModel.movies, id: \.id) { movie in
                    Button(action: {
                        if let movieID = movie.id {
                            router.navigate(to: .movieDetails(movieID: movieID))
                        }
                    }) {
                        MovieCardView(movie: movie, didFavoriteTap: {
                            if let index = viewModel.movies.firstIndex(where: { $0.id == movie.id }) {
                                viewModel.favoriteMovieTapped.send(index)
                            }
                        })
                    }
                }
            }
        }
    }

    private func makeActorListView () -> some View {
        VStack {
            SectionHeaderView(title: "Actors")
                .padding(.top, 8)
            
            ActorSectionView(
                actors: viewModel.movieCast,
                onActorSelected: { actor in
                    router.navigate(to: .actorDetails(actorID: actor.id ?? 0))
                }
            )
        }
    }
}
