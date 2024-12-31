//
//  HomeViewModel.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 15/12/2024.
//

import Combine
import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var upcomingViewState: ViewState = .loading
    @Published var mostPopularViewState: ViewState = .loading
    @Published var actorsViewState: ViewState = .loading

    var viewAppeared: PassthroughSubject<Void, Never> = .init()
    var logoutTapped: PassthroughSubject<Void, Never> = .init()
    var favoriteTapped: PassthroughSubject<Int, Never> = .init()

    @Published var showSignUp: Bool = false

    var upcomingMovies: [Movie] = []
    var mostPopularMovies: [Movie] = []
    var actors: [MovieCast] = []

    private let removeSessionUseCase: RemoveSessionUseCaseProtocol
    private let upcomingMoviesUseCase: GetUpcomingMoviesUseCaseProtocol
    private let mostPopularMoviesUseCase: GetMostPopularMoviesUseCaseProtocol
    private let getActorsListUseCase: GetActorsListUseCaseProtocol

    private let addToFavoritesUseCase: AddToFavoritesUseCaseProtocol
    private let isMovieFavorieUseCase: IsMovieFavorieUseCaseProtocol
    private let removeMovieFromFavoritesUseCase: RemoveMovieFromFavoritesUseCaseProtocol

    private var cancellables = Set<AnyCancellable>()

    init(
        removeSessionUseCase: RemoveSessionUseCaseProtocol = RemoveSessionUseCase(),
        upcomingMoviesUseCase: GetUpcomingMoviesUseCaseProtocol = GetUpcomingMoviesUseCase(),
        mostPopularMoviesUseCase: GetMostPopularMoviesUseCaseProtocol = GetMostPopularMoviesUseCase(),
        getActorsListUseCase: GetActorsListUseCaseProtocol = GetActorsListUseCase(),
        addToFavoritesUseCase: AddToFavoritesUseCaseProtocol = AddToFavoritesUseCase(),
        isMovieFavorieUseCase: IsMovieFavorieUseCaseProtocol = IsMovieFavorieUseCase(),
        removeMovieFromFavoritesUseCase: RemoveMovieFromFavoritesUseCaseProtocol = RemoveMovieFromFavoritesUseCase()
    ) {
        self.removeSessionUseCase = removeSessionUseCase
        self.upcomingMoviesUseCase = upcomingMoviesUseCase
        self.mostPopularMoviesUseCase = mostPopularMoviesUseCase
        self.getActorsListUseCase = getActorsListUseCase

        self.addToFavoritesUseCase = addToFavoritesUseCase
        self.isMovieFavorieUseCase = isMovieFavorieUseCase
        self.removeMovieFromFavoritesUseCase = removeMovieFromFavoritesUseCase

        setupObservers()
    }

    func setupObservers() {
        viewAppeared
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }

                getUpcomingMovies()
                getMostPopularMovies()
                getActorsList()
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

        logoutTapped
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }

                logout()
            }
            .store(in: &cancellables)
    }

    private func favoriteTapped(movieIndex: Int) {
        let movie = mostPopularMovies[movieIndex]
        guard let movieId = movie.id else { return }

        if isMovieFavorieUseCase.execute(movieId: movieId) {
            removeMovieFromFavoritesUseCase.execute(movieId: movieId)
        } else {
            addToFavoritesUseCase.execute(movie: movie)
        }
    }

    private func logout() {
        removeSessionUseCase.execute()
        showSignUp = true
    }

    private func getMostPopularMovies() {
        mostPopularViewState = .loading

        mostPopularMoviesUseCase.execute()
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    DispatchQueue.main.async { [weak self] in
                        guard let self else { return }

                        mostPopularViewState = .failed
                    }
                }
            }, receiveValue: { [weak self] response in
                guard let self else { return }

                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }

                    mostPopularMovies = mapMostPopularMoviesResponse(response: response)
                    mostPopularViewState = mostPopularMovies.isEmpty ? .empty : .loaded
                }
            })
            .store(in: &cancellables)
    }

    private func mapMostPopularMoviesResponse(response: MoviesListResponse) -> [Movie] {
        let movies = response.results ?? []
        var formattedMovies: [Movie] = []

        for movie in movies {
            if let movieId = movie.id {
                formattedMovies.append(Movie(adult: movie.adult, backdropPath: movie.backdropPath, genreIds: movie.genreIds, id: movie.id, originalLanguage: movie.originalLanguage, originalTitle: movie.originalTitle, overview: movie.overview, popularity: movie.popularity, posterPath: movie.posterPath, releaseDate: movie.releaseDate, title: movie.title, video: movie.video, voteAverage: movie.voteAverage, voteCount: movie.voteCount, isFavorite: isMovieFavorieUseCase.execute(movieId: movieId)))
            }
        }

        return formattedMovies
    }

    private func getUpcomingMovies() {
        upcomingViewState = .loading

        upcomingMoviesUseCase.execute()
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    DispatchQueue.main.async { [weak self] in
                        guard let self else { return }

                        upcomingViewState = .failed
                    }
                }
            }, receiveValue: { [weak self] response in
                guard let self else { return }

                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }

                    upcomingMovies = Array(response.results?.shuffled().prefix(5) ?? [])
                    upcomingViewState = upcomingMovies.isEmpty ? .empty : .loaded
                }
            })
            .store(in: &cancellables)
    }

    private func getActorsList() {
        actorsViewState = .loading

        getActorsListUseCase.execute()
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    DispatchQueue.main.async { [weak self] in
                        guard let self else { return }

                        actorsViewState = .failed
                    }
                }
            }, receiveValue: { [weak self] response in
                guard let self else { return }

                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }

                    actors = Array(response.results?.shuffled().prefix(5) ?? [])
                    actorsViewState = actors.isEmpty ? .empty : .loaded
                }
            })
            .store(in: &cancellables)
    }
}
