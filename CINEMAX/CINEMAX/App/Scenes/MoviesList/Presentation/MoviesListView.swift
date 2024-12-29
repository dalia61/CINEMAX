//
//  MoviesListView.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 13/12/2024.
//

import SwiftUI

struct MoviesListView: View {
    @ObservedObject var viewModel: MoviesListViewModel
    @EnvironmentObject var router: Router

    init(viewModel: MoviesListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    NavigationBarView(
                        title: "Most Popular",
                        onDismiss: {
                            router.navigateBack()
                        }
                    )
                    
                    Picker("Sort Options", selection: $viewModel.selectedSortOption) {
                        ForEach(SortOption.allCases, id: \.self) { option in
                            Text(option.rawValue)
                        }
                    }
                    .pickerStyle(.menu)
                    .tint(.white)
                    .background(Color("SoftAccent"))
                    .cornerRadius(8)
                }
                .padding([.top,.bottom], 8)
                
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
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .background(Color.darkAccent)
            .onAppear {
                viewModel.viewAppeared.send()
            }
        }
        .navigationBarHidden(true)
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

#Preview {
    MoviesListView(viewModel: MoviesListViewModel())
}
