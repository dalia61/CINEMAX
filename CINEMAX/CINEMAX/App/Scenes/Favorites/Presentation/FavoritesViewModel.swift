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
    var favoriteMovieTapped: PassthroughSubject<Int, Never> = .init()
    var favoriteMovieCastTapped: PassthroughSubject<Int, Never> = .init()

    var movies: [Movie] = []
    var moviesCast: [Cast] = []

    private let getFavoriteMoviesUseCase: GetFavoriteMoviesUseCaseProtocol
    private let getFavoriteMoviesCastUseCase: GetFavoriteMoviesCastUseCaseProtocol
    private let removeMovieFromFavoritesUseCase: RemoveMovieFromFavoritesUseCaseProtocol
    private let removeMovieCastFromFavoritesUseCase: RemoveMovieCastFromFavoritesUseCaseProtocol

    private var cancellables = Set<AnyCancellable>()

    init(getFavoriteMoviesUseCase: GetFavoriteMoviesUseCaseProtocol = GetFavoriteMoviesUseCase(),
         getFavoriteMoviesCastUseCase: GetFavoriteMoviesCastUseCaseProtocol = GetFavoriteMoviesCastUseCase(),
         removeMovieFromFavoritesUseCase: RemoveMovieFromFavoritesUseCaseProtocol = RemoveMovieFromFavoritesUseCase(),
         removeMovieCastFromFavoritesUseCase: RemoveMovieCastFromFavoritesUseCaseProtocol = RemoveMovieCastFromFavoritesUseCase()) {
        self.getFavoriteMoviesUseCase = getFavoriteMoviesUseCase
        self.getFavoriteMoviesCastUseCase = getFavoriteMoviesCastUseCase
        self.removeMovieFromFavoritesUseCase = removeMovieFromFavoritesUseCase
        self.removeMovieCastFromFavoritesUseCase = removeMovieCastFromFavoritesUseCase

        setupObservers()
    }

    func setupObservers() {
        viewAppeared
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }

                getFavoriteMovies()
                getFavoriteMoviesCast()
            }
            .store(in: &cancellables)

        favoriteMovieTapped
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] index in
                guard let self = self else { return }

                favoriteMovieTapped(movieIndex: index)
            }
            .store(in: &cancellables)
        
        favoriteMovieCastTapped
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] index in
                guard let self = self else { return }

                favoriteMovieCastTapped(movieIndex: index)
            }
            .store(in: &cancellables)
    }

    func getFavoriteMovies() {
        let savedMovies = getFavoriteMoviesUseCase.execute()
        movies = mapMoviesResponse(movies: savedMovies)

        state = movies.isEmpty && moviesCast.isEmpty ? .empty : .loaded
    }

    func getFavoriteMoviesCast() {
        let savedMovies = getFavoriteMoviesCastUseCase.execute()
        moviesCast = mapMoviesCastResponse(movies: savedMovies)

        state = movies.isEmpty && moviesCast.isEmpty ? .empty : .loaded
    }
    
    private func mapMoviesResponse(movies: [Movie]) -> [Movie] {
        var formattedMovies: [Movie] = []

        for movie in movies {
            formattedMovies.append(Movie(adult: movie.adult, backdropPath: movie.backdropPath, genreIds: movie.genreIds, id: movie.id, originalLanguage: movie.originalLanguage, originalTitle: movie.originalTitle, overview: movie.overview, popularity: movie.popularity, posterPath: movie.posterPath, releaseDate: movie.releaseDate, title: movie.title, video: movie.video, voteAverage: movie.voteAverage, voteCount: movie.voteCount, isFavorite: true))
        }

        return formattedMovies
    }
    
    private func mapMoviesCastResponse(movies: [Cast]) -> [Cast] {
        var formattedMovies: [Cast] = []

        for movie in movies {
            formattedMovies.append(Cast(adult: movie.adult, backdropPath: movie.backdropPath, genreIDS: movie.genreIDS, id: movie.id, originalLanguage: movie.originalLanguage, originalTitle: movie.originalTitle, overview: movie.overview, popularity: movie.popularity, posterPath: movie.posterPath, releaseDate: movie.releaseDate, title: movie.title, video: movie.video, voteAverage: movie.voteAverage, voteCount: movie.voteCount, character: movie.character, creditID: movie.creditID, order: movie.order, isFavorite: true))
        }

        return formattedMovies
    }

    
    private func favoriteMovieTapped(movieIndex: Int) {
        let movie = movies[movieIndex]
        guard let movieId = movie.id else { return }

        removeMovieFromFavoritesUseCase.execute(movieId: movieId)
        getFavoriteMovies()
    }
    
    private func favoriteMovieCastTapped(movieIndex: Int) {
        let moviesCast = moviesCast[movieIndex]
        guard let movieId = moviesCast.id else { return }

        removeMovieCastFromFavoritesUseCase.execute(movieId: movieId)
        getFavoriteMoviesCast()
    }
}
