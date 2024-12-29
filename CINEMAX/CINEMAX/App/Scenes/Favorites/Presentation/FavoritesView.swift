//
//  FavoritesView.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 10/12/2024.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: FavoritesViewModel
    @EnvironmentObject var router: Router

    init(viewModel: FavoritesViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            VStack {
                Text("Wishlist")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.top, 16)
                
                ScrollView(.vertical, showsIndicators: false) {
                    switch viewModel.state {
                    case .loading:
                        makeLoadingView()
                        
                    case .empty:
                        makeEmptyView()
                        
                    case .failed:
                        makeFailureView()
                        
                    case .loaded:
                        makeMoviesListView()
                    }
                }
                .padding(.horizontal, 16)
            }
            .onAppear {
                viewModel.viewAppeared.send()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.darkAccent)
        }
    }
    
    private func makeLoadingView() -> some View {
        ProgressView()
            .tint(.white)
    }

    private func makeEmptyView() -> some View {
        Text("No Data Available")
            .foregroundColor(.gray)
            .padding()
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
            LazyVStack(spacing: 16) {
                ForEach(viewModel.movies, id: \.id) { movie in
                    Button(action: {
                        if let movieID = movie.id {
                            router.navigate(to: .movieDetails(movieID: movieID))
                        }
                    }) {
                        MovieCardView(movie: movie, didFavoriteTap: {
                            if let index = viewModel.movies.firstIndex(where: { $0.id == movie.id }) {
                                viewModel.favoriteTapped.send(index)
                            }
                        })
                    }
                }
            }
        }
    }
}
