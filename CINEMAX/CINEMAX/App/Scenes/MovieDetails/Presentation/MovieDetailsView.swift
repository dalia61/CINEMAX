//
//  MovieDetailView.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 09/12/2024.
//

import SwiftUI

struct MovieDetailsView: View {
    @ObservedObject var viewModel: MovieDetailsViewModel
    @Environment(\.dismiss) private var dismiss
    
    init(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            NavigationBarView(
                title: viewModel.movieDetails?.title ?? "",
                onDismiss: {
                    dismiss()
                }
            )
            
            switch viewModel.detailsState {
            case .loading:
                makeLoadingView()
                
            case .empty:
                makeEmptyView()
                
            case .failed:
                makeFailureView()
                
            case .loaded:
                makeMovieDetailsView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.darkAccent)
        .onAppear {
            viewModel.viewAppeared.send()
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
    
    private func makeMovieDetailsView() -> some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 16) {
                    makeMoviePoster()
                    
                    makeMovieDataView()
                    
                    makeMovieHomePageButton()
                    
                    makeMovieOverview()
                    
                    makeMovieCast()
                    
                    makeRelatedMovies()
                }
                .padding(.horizontal, 16)
            }
        }
    }
    
    private func makeMoviePoster() -> some View {
        ZStack(alignment: .topLeading) {
            ImageView(imageURL: viewModel.movieDetails?.posterPath)
                .frame(height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            HStack {
                RateView(rating: viewModel.movieDetails?.voteAverage ?? 0)
                Spacer()
                FavoriteView(isFavorite: viewModel.isFavorited, didTap: {
                    viewModel.movieFavoriteTapped.send()
                })
            }
            .padding()
        }
    }
    
    private func makeMovieDataView() -> some View {
        VStack {
            HStack {
                DetailsView(imageName: "calendar", text: viewModel.movieDetails?.releaseDate ?? "")
                DetailsView(imageName: "network", text: viewModel.movieDetails?.language ?? "")
                DetailsView(imageName: "clock.fill", text: "\(viewModel.movieDetails?.runtime ?? 0) Minutes")
            }
            
            DetailsView(imageName: "film", text: viewModel.movieDetails?.genresString ?? "")
        }
        .multilineTextAlignment(.center)
    }
    
    private func makeMovieHomePageButton() -> some View {
        Button(action: {
            var urlString = viewModel.movieDetails?.homepage ?? ""
            if urlString.isEmpty {
                urlString = "https://www.themoviedb.org/"
            }
            guard let url = URL(string: urlString) else {
                return
            }
            
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }) {
            HStack {
                Image(systemName: "play.fill")
                Text("Home page")
            }
            .font(.system(size: 16, weight: .medium))
            .frame(height: 50)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .background(Color.blueAccent)
            .cornerRadius(32)
        }
    }
    
    private func makeMovieOverview() -> some View {
        VStack {
            Text("Story Line")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("\(viewModel.movieDetails?.overview ?? "")")
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private func makeMovieCast() -> some View {
        VStack {
            SectionHeaderView(title: "Cast and Crew")
            
            switch viewModel.castState {
            case .loading:
                makeLoadingView()
            case .empty:
                EmptyView()
            case .failed:
                EmptyView()
            case .loaded:
                ActorSectionView(
                    actors: viewModel.movieCast,
                    onActorSelected: { actor in
                    })
            }
        }
    }
    
    private func makeRelatedMovies() -> some View {
        VStack {
            SectionHeaderView(title: "Related Movies")
            
            switch viewModel.relatedMoviesState {
            case .loading:
                makeLoadingView()
            case .empty:
                EmptyView()
            case .failed:
                EmptyView()
            case .loaded:
                MoviesSectionView(
                    movies: viewModel.relatedMovies,
                    onMovieSelected: { movie in
                    }, onMovieFavorite: { index in
                        viewModel.favoriteTapped.send(index)
                    })
            }
        }
    }
}
