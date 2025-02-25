//
//  MovieDetailsViewModel.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 12/12/2024.
//

import Foundation
import Combine

class MovieDetailsViewModel: ObservableObject {
    @Published var detailsState: ViewState = .loading
    @Published var castState: ViewState = .loading
    @Published var relatedMoviesState: ViewState = .loading
    @Published var isFavorited: Bool = false

    var viewAppeared: PassthroughSubject<Void, Never> = .init()
    var favoriteTapped: PassthroughSubject<Int, Never> = .init()
    var movieFavoriteTapped: PassthroughSubject<Void, Never> = .init()

    let movieID: Int
    var movieDetails: MovieDetails?
    var movieCast: [MovieCast] = []
    var relatedMovies: [Movie] = []

    private let getMovieDetailsUseCase: GetMovieDetailsUseCaseProtocol
    private let getMovieCastUseCase: GetMovieCastUseCaseProtocol
    private let getRelatedMoviesUseCase: GetRelatedMoviesUseCaseProtocol

    private let addToFavoritesUseCase: AddToFavoritesUseCaseProtocol
    private let isMovieFavorieUseCase: IsMovieFavorieUseCaseProtocol
    private let removeMovieFromFavoritesUseCase: RemoveMovieFromFavoritesUseCaseProtocol

    private var cancellables = Set<AnyCancellable>()

    init(
        movieID: Int,
        getMovieDetailsUseCase: GetMovieDetailsUseCaseProtocol = GetMovieDetailsUseCase(),
        getMovieCastUseCase: GetMovieCastUseCaseProtocol = GetMovieCastUseCase(),
        getRelatedMoviesUseCase: GetRelatedMoviesUseCaseProtocol = GetRelatedMoviesUseCase(),
        addToFavoritesUseCase: AddToFavoritesUseCaseProtocol = AddToFavoritesUseCase(),
        isMovieFavorieUseCase: IsMovieFavorieUseCaseProtocol = IsMovieFavorieUseCase(),
        removeMovieFromFavoritesUseCase: RemoveMovieFromFavoritesUseCaseProtocol = RemoveMovieFromFavoritesUseCase()
    ) {
        self.movieID = movieID

        self.getMovieDetailsUseCase = getMovieDetailsUseCase
        self.getMovieCastUseCase = getMovieCastUseCase
        self.getRelatedMoviesUseCase = getRelatedMoviesUseCase

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
                
                getMovieDetails()
                getMovieCast()
                getRelatedMovies()
            }
            .store(in: &cancellables)
        
        favoriteTapped
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] index in
                guard let self = self else { return }

                relatedMovieFavoriteTapped(movieIndex: index)
            }
            .store(in: &cancellables)
        
        movieFavoriteTapped
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }

                movieDetailsFavoriteTapped()
            }
            .store(in: &cancellables)
    }
    
    private func movieDetailsFavoriteTapped() {
        if isMovieFavorieUseCase.execute(movieId: movieID) {
            removeMovieFromFavoritesUseCase.execute(movieId: movieID)
        } else {
            let genresIDs: [Int] = movieDetails?.genres?.compactMap { $0.id } ?? []
            let movie = Movie(adult: movieDetails?.adult, backdropPath: movieDetails?.backdropPath, genreIds: genresIDs, id: movieDetails?.id, originalLanguage: movieDetails?.originalLanguage, originalTitle: movieDetails?.originalTitle, overview: movieDetails?.overview, popularity: movieDetails?.popularity, posterPath: movieDetails?.posterPath, releaseDate: movieDetails?.releaseDate, title: movieDetails?.title, video: movieDetails?.video, voteAverage: movieDetails?.voteAverage, voteCount: movieDetails?.voteCount)
            addToFavoritesUseCase.execute(movie: movie)
        }
    }

    private func relatedMovieFavoriteTapped(movieIndex: Int) {
        let movie = relatedMovies[movieIndex]
        guard let movieId = movie.id else {return }

        if isMovieFavorieUseCase.execute(movieId: movieId) {
            removeMovieFromFavoritesUseCase.execute(movieId: movieId)
        } else {
            addToFavoritesUseCase.execute(movie: movie)
        }
    }

    private func getMovieDetails() {
        detailsState = .loading

        getMovieDetailsUseCase.execute(movieId: movieID)
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    DispatchQueue.main.async { [weak self] in
                        guard let self else { return }

                        detailsState = .failed
                    }
                }
            }, receiveValue: { [weak self] response in
                guard let self else { return }
                
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    
                    movieDetails = response
                    isFavorited = self.isMovieFavorieUseCase.execute(movieId: movieID)
                    detailsState = .loaded
                }
            })
            .store(in: &cancellables)
    }
    
    private func getMovieCast() {
        castState = .loading

        getMovieCastUseCase.execute(movieId: movieID)
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    DispatchQueue.main.async { [weak self] in
                        guard let self else { return }

                        castState = .failed
                    }
                }
            }, receiveValue: { [weak self] response in
                guard let self else { return }
                
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    
                    movieCast = Array(response.cast?.sorted(by: {
                        $0.popularity ?? 0 > $1.popularity ?? 0
                    }) ?? [])
                    castState = .loaded
                }
            })
            .store(in: &cancellables)
    }
    
    private func getRelatedMovies() {
        relatedMoviesState = .loading

        getRelatedMoviesUseCase.execute(movieId: movieID)
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    DispatchQueue.main.async { [weak self] in
                        guard let self else { return }

                        relatedMoviesState = .failed
                    }
                }
            }, receiveValue: { [weak self] response in
                guard let self else { return }
                
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    
                    relatedMovies = Array((response.results?.sorted(by: {
                        $0.popularity ?? 0 > $1.popularity ?? 0
                    }) ?? []))
                    relatedMoviesState = .loaded
                }
            })
            .store(in: &cancellables)
    }
}
