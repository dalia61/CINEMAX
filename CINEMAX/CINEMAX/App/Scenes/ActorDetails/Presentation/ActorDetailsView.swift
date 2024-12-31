//
//  ActorDetailsView.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 16/12/2024.
//

import SwiftUI

struct ActorDetailsView: View {
    @ObservedObject var viewModel: ActorDetailsViewModel
    @EnvironmentObject var router: Router

    init(viewModel: ActorDetailsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            NavigationBarView(
                title: viewModel.actorDetails?.name ?? "",
                onDismiss: {
                    router.navigateBack()
                }
            )
            .padding(.horizontal, 16)
            .padding(.bottom, 8)
            
            switch viewModel.detailsState {
            case .loading:
                makeLoadingView()
                
            case .empty:
                makeEmptyView()
                
            case .failed:
                makeFailureView()
                
            case .loaded:
                makeActorDetailsView()
            }
            Spacer()
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
    
    private func makeActorDetailsView() -> some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 16) {
                    makeActorPoster()
                    
                    makeActorDataView()
                    
                    makeActorHomePageButton()
                    
                    makeActorOverview()
                    
                    makeRelatedMovies()
                }
                .padding(.horizontal, 16)
            }
        }
    }
    
    private func makeActorPoster() -> some View {
        ZStack(alignment: .topLeading) {
            ImageView(imageURL: viewModel.actorDetails?.profilePath)
                .frame(height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
    
    private func makeActorDataView() -> some View {
        VStack {
            HStack {
                DetailsView(imageName: "calendar", text: viewModel.actorDetails?.birthday ?? "")
                DetailsView(imageName: "network", text: viewModel.actorDetails?.placeOfBirth ?? "")
                DetailsView(imageName: "medal", text: "\(viewModel.actorDetails?.popularity ?? 0)")
            }
            
            DetailsView(imageName: "film", text: viewModel.actorDetails?.knownForDepartment ?? "")
        }
        .multilineTextAlignment(.center)
    }
    
    private func makeActorHomePageButton() -> some View {
        Button(action: {
            var urlString = viewModel.actorDetails?.homepage ?? ""
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
    
    private func makeActorOverview() -> some View {
        VStack {
            Text("Story Line")
                .padding(.bottom, 8)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("\(viewModel.actorDetails?.biography ?? "")")
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
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
                RelatedMoviesSectionView(
                    movies: viewModel.relatedMovies,
                    onMovieSelected: { movie in
                        router.navigate(to: .movieDetails(movieID: movie.id ?? 0))
                    }, onMovieFavorite: { index in
                        viewModel.favoriteTapped.send(index)
                    })
            }
        }
    }
}

