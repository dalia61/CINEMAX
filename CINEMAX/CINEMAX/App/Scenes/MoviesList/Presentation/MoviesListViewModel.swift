//
//  MoviesListViewModel.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 13/12/2024.
//

import Foundation
import Combine

class MoviesListViewModel: ObservableObject {
    @Published var state: ViewState = .loading
    @Published var selectedSortOption: SortOption = .popularity

    var viewAppeared: PassthroughSubject<Void, Never> = .init()
    var favoriteTapped: PassthroughSubject<Int, Never> = .init()

    var movies: [Movie] = []

    private let mostPopularMoviesUseCase: GetMostPopularMoviesUseCaseProtocol
    private let sortMoviesUseCase: SortMoviesUseCaseProtocol

    private let addToFavoritesUseCase: AddToFavoritesUseCaseProtocol
    private let isMovieFavorieUseCase: IsMovieFavorieUseCaseProtocol
    private let removeFromFavoritesUseCase: RemoveFromFavoritesUseCaseProtocol

    private var cancellables = Set<AnyCancellable>()

    init(
        mostPopularMoviesUseCase: GetMostPopularMoviesUseCaseProtocol = GetMostPopularMoviesUseCase(),
        sortMoviesMoviesUseCase: SortMoviesUseCaseProtocol = SortMoviesUseCase(),
        addToFavoritesUseCase: AddToFavoritesUseCaseProtocol = AddToFavoritesUseCase(),
        isMovieFavorieUseCase: IsMovieFavorieUseCaseProtocol = IsMovieFavorieUseCase(),
        removeFromFavoritesUseCase: RemoveFromFavoritesUseCaseProtocol = RemoveFromFavoritesUseCase()
    ) {
        self.mostPopularMoviesUseCase = mostPopularMoviesUseCase
        self.sortMoviesUseCase = sortMoviesMoviesUseCase
        self.addToFavoritesUseCase = addToFavoritesUseCase
        self.isMovieFavorieUseCase = isMovieFavorieUseCase
        self.removeFromFavoritesUseCase = removeFromFavoritesUseCase

        setupObservers()
    }
    
    func setupObservers() {
        viewAppeared
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }

                getMostPopularMovies()
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

        $selectedSortOption
            .sink { [weak self] sortOption in
                guard let self else { return }

                movies = sortMoviesUseCase.execute(movies: movies, sortBy: sortOption)
                state = movies.isEmpty ? .empty : .loaded
            }
            .store(in: &cancellables)
    }
    
    private func favoriteTapped(movieIndex: Int) {
        let movie = movies[movieIndex]
        guard let movieId = movie.id else {return }

        if isMovieFavorieUseCase.execute(movieId: movieId) {
            removeFromFavoritesUseCase.execute(movieId: movieId)
        } else {
            addToFavoritesUseCase.execute(movie: movie)
        }
    }
    
    private func getMostPopularMovies() {
        state = .loading

        mostPopularMoviesUseCase.execute { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }

                    movies = mapMoviesResponse(response: response)
                    state = movies.isEmpty ? .empty : .loaded
                }

            case .failure:
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }

                    state = .failed
                }
            }
        }
    }
    
    private func mapMoviesResponse(response: MoviesListResponse) -> [Movie] {
        let sortedMovies = sortMoviesUseCase.execute(movies: response.results ?? [], sortBy: selectedSortOption)
        var formattedMovies: [Movie] = []

        for movie in sortedMovies {
            if let movieId = movie.id {
                formattedMovies.append(Movie(adult: movie.adult, backdropPath: movie.backdropPath, genreIds: movie.genreIds, id: movie.id, originalLanguage: movie.originalLanguage, originalTitle: movie.originalTitle, overview: movie.overview, popularity: movie.popularity, posterPath: movie.posterPath, releaseDate: movie.releaseDate, title: movie.title, video: movie.video, voteAverage: movie.voteAverage, voteCount: movie.voteCount, isFavorite: isMovieFavorieUseCase.execute(movieId: movieId)))
            }
        }
        
        return formattedMovies
    }
}

enum SortOption: String, CaseIterable {
    case popularity = "Popularity"
    case rating = "Rating"
    case releaseDate = "Release Date"
}
