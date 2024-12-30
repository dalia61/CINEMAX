//
//  SearchViewModel.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 12/12/2024.
//

import Combine
import Foundation

class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var moviesState: ViewState = .empty
    @Published var actorsState: ViewState = .empty

    var favoriteTapped: PassthroughSubject<Int, Never> = .init()

    var movies: [Movie] = []
    var movieCast: [MovieCast] = []

    private let searchMoviesUseCase: SearchMoviesUseCaseProtocol
    private let searchActorsUseCase: SearchActorsUseCaseProtocol
    
    private let addToFavoritesUseCase: AddToFavoritesUseCaseProtocol
    private let isMovieFavorieUseCase: IsMovieFavorieUseCaseProtocol
    private let removeFromFavoritesUseCase: RemoveFromFavoritesUseCaseProtocol

    private var cancellables = Set<AnyCancellable>()

    init(
        searchMoviesUseCase: SearchMoviesUseCaseProtocol = SearchMoviesUseCase(),
        searchActorsUseCase: SearchActorsUseCaseProtocol = SearchActorsUseCase(),
        addToFavoritesUseCase: AddToFavoritesUseCaseProtocol = AddToFavoritesUseCase(),
        isMovieFavorieUseCase: IsMovieFavorieUseCaseProtocol = IsMovieFavorieUseCase(),
        removeFromFavoritesUseCase: RemoveFromFavoritesUseCaseProtocol = RemoveFromFavoritesUseCase()
    ) {
        self.searchMoviesUseCase = searchMoviesUseCase
        self.searchActorsUseCase = searchActorsUseCase

        self.addToFavoritesUseCase = addToFavoritesUseCase
        self.isMovieFavorieUseCase = isMovieFavorieUseCase
        self.removeFromFavoritesUseCase = removeFromFavoritesUseCase

        setupObservers()
    }
    
    func setupObservers() {
        $searchText
            .receive(on: DispatchQueue.main)
            .debounce(for: 1, scheduler: DispatchQueue.main)
            .sink { [weak self] query in
                guard let self = self else { return }
                
                searchForMovie(movieName: query)
                searchForActor(actorName: query)
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
    
    private func favoriteTapped(movieIndex: Int) {
        let movie = movies[movieIndex]
        guard let movieId = movie.id else {return }

        if isMovieFavorieUseCase.execute(movieId: movieId) {
            removeFromFavoritesUseCase.execute(movieId: movieId)
        } else {
            addToFavoritesUseCase.execute(movie: movie)
        }
    }

    private func searchForActor(actorName: String) {
        movieCast.removeAll()

        if !actorName.isEmpty {
            actorsState = .loading

            searchActorsUseCase.execute(actorName: actorName)
                .sink(receiveCompletion: { completion in
                    if case .failure = completion {
                        DispatchQueue.main.async { [weak self] in
                            guard let self else { return }

                            actorsState = .failed
                        }
                    }
                }, receiveValue: { [weak self] response in
                    guard let self else { return }
                    
                    DispatchQueue.main.async { [weak self] in
                        guard let self else { return }

                        movieCast = mapActorsResponse(response: response)
                        actorsState = movieCast.isEmpty ? .empty : .loaded
                    }
                })
                .store(in: &cancellables)
        } else {
            actorsState = .empty
        }
    }
    
    private func searchForMovie(movieName: String) {
        movies.removeAll()

        if !movieName.isEmpty {
            moviesState = .loading

            searchMoviesUseCase.execute(movieName: movieName)
                .sink(receiveCompletion: { completion in
                    if case .failure = completion {
                        DispatchQueue.main.async { [weak self] in
                            guard let self else { return }

                            moviesState = .failed
                        }
                    }
                }, receiveValue: { [weak self] response in
                    guard let self else { return }
                    
                    DispatchQueue.main.async { [weak self] in
                        guard let self else { return }

                        movies = mapMoviesResponse(response: response)
                        moviesState = movies.isEmpty ? .empty : .loaded
                    }
                })
                .store(in: &cancellables)
        } else {
            moviesState = .empty
        }
    }
    
    private func mapActorsResponse(response: ActorsListResponse) -> [MovieCast] {
        return response.results ?? []
    }
    
    private func mapMoviesResponse(response: MoviesListResponse) -> [Movie] {
        let movies = response.results ?? []
        var formattedMovies: [Movie] = []

        for movie in movies {
            if let movieId = movie.id {
                formattedMovies.append(Movie(adult: movie.adult, backdropPath: movie.backdropPath, genreIds: movie.genreIds, id: movie.id, originalLanguage: movie.originalLanguage, originalTitle: movie.originalTitle, overview: movie.overview, popularity: movie.popularity, posterPath: movie.posterPath, releaseDate: movie.releaseDate, title: movie.title, video: movie.video, voteAverage: movie.voteAverage, voteCount: movie.voteCount, isFavorite: isMovieFavorieUseCase.execute(movieId: movieId)))
            }
        }
        
        return formattedMovies
    }
}
