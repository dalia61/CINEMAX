//
//  FavoritesViewModel.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 11/12/2024.
//

import Combine
import Foundation

class FavoritesViewModel: ObservableObject {
    @Published var state: ViewState = .loading

    var viewAppeared: PassthroughSubject<Void, Never> = .init()
    var favoriteTapped: PassthroughSubject<Int, Never> = .init()

    var movies: [Movie] = []

    private let getFavoriteMoviesUseCase: GetFavoriteMoviesUseCaseProtocol
    private let removeFromFavoritesUseCase: RemoveFromFavoritesUseCaseProtocol

    private var cancellables = Set<AnyCancellable>()

    init(getFavoriteMoviesUseCase: GetFavoriteMoviesUseCaseProtocol = GetFavoriteMoviesUseCase(),
         removeFromFavoritesUseCase: RemoveFromFavoritesUseCaseProtocol = RemoveFromFavoritesUseCase()) {
        self.getFavoriteMoviesUseCase = getFavoriteMoviesUseCase
        self.removeFromFavoritesUseCase = removeFromFavoritesUseCase

        setupObservers()
    }

    func setupObservers() {
        viewAppeared
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }

                getFavoriteMovies()
            }
            .store(in: &cancellables)

        favoriteTapped
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] index in
                guard let self = self else { return }

                favoriteTapped(movieIndex: index)
            }
            .store(in: &cancellables)
    }

    func getFavoriteMovies() {
        let savedMovies = getFavoriteMoviesUseCase.execute()
        movies = mapMoviesResponse(movies: savedMovies)

        state = movies.isEmpty ? .empty : .loaded
    }

    private func mapMoviesResponse(movies: [Movie]) -> [Movie] {
        var formattedMovies: [Movie] = []

        for movie in movies {
            formattedMovies.append(Movie(adult: movie.adult, backdropPath: movie.backdropPath, genreIds: movie.genreIds, id: movie.id, originalLanguage: movie.originalLanguage, originalTitle: movie.originalTitle, overview: movie.overview, popularity: movie.popularity, posterPath: movie.posterPath, releaseDate: movie.releaseDate, title: movie.title, video: movie.video, voteAverage: movie.voteAverage, voteCount: movie.voteCount, isFavorite: true))
        }

        return formattedMovies
    }

    private func favoriteTapped(movieIndex: Int) {
        let movie = movies[movieIndex]
        guard let movieId = movie.id else { return }

        removeFromFavoritesUseCase.execute(movieId: movieId)
        getFavoriteMovies()
    }
}
