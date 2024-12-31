//
//  MoviesRepo.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 12/12/2024.
//

import Combine

struct MoviesRepo: MoviesRepoProtocol {
    let remoteMoviesDataSource: RemoteMoviesDataSourceProtocol
    let localMoviesDataSource: LocalMoviesDataSourceProtocol

    init(
        remoteMoviesDataSource: RemoteMoviesDataSourceProtocol = RemoteMoviesDataSource(),
        localMoviesDataSource: LocalMoviesDataSourceProtocol = LocalMoviesDataSource()
    ) {
        self.remoteMoviesDataSource = remoteMoviesDataSource
        self.localMoviesDataSource = localMoviesDataSource
    }

    func fetchUpcoming() -> AnyPublisher<MoviesListResponse, NetworkError> {
        return remoteMoviesDataSource.fetchUpcoming()
    }
    
    func fetchMostPopular() -> AnyPublisher<MoviesListResponse, NetworkError> {
        return remoteMoviesDataSource.fetchMostPopular()
    }
    
    func fetchAllActors() -> AnyPublisher<ActorsListResponse, NetworkError> {
        return remoteMoviesDataSource.fetchActors()
    }
    
    func searchMovie(movieName: String) -> AnyPublisher<MoviesListResponse, NetworkError> {
        return remoteMoviesDataSource.searchMovie(movieName: movieName)
    }

    func searchActor(actorName: String) -> AnyPublisher<ActorsListResponse, NetworkError> {
        return remoteMoviesDataSource.searchActor(actorName: actorName)
    }
    
    func fetchMovieDetails(movieID: Int) -> AnyPublisher<MovieDetails, NetworkError> {
        return remoteMoviesDataSource.fetchMovieDetails(movieID: movieID)
    }
    
    func fetchMovieCast(movieID: Int) -> AnyPublisher<MovieCastResponse, NetworkError> {
        return remoteMoviesDataSource.fetchMovieCast(movieID: movieID)
    }

    func fetchRelatedMovies(movieID: Int) -> AnyPublisher<MoviesListResponse, NetworkError> {
        return remoteMoviesDataSource.fetchRelatedMovies(movieID: movieID)
    }
    
    func fetchActorRelatedMovies(actorID: Int) -> AnyPublisher<ActorRelatedMoviesResponse, NetworkError> {
        return remoteMoviesDataSource.fetchActorRelatedMovies(actorID: actorID)
    }
    
    func fetchActorDetails(actorID: Int) -> AnyPublisher<ActorDetails, NetworkError> {
        return remoteMoviesDataSource.fetchActorDetails(actorID: actorID)
    }

    func addToFavorites(movie: Movie) {
        localMoviesDataSource.addToFavorites(movie: movie)
    }
    
    func addToFavorites(movieCast: Cast) {
        localMoviesDataSource.addToFavorites(movieCast: movieCast)
    }
    
    func removeMovieFromFavorites(movieId: Int) {
        localMoviesDataSource.removeMovieFromFavorites(movieId: movieId)
    }
    
    func removeMovieCastFromFavorites(movieId: Int) {
        localMoviesDataSource.removeMovieCastFromFavorites(movieId: movieId)
    }
    
    func isMovieFavorite(movieId: Int) -> Bool {
        return localMoviesDataSource.isMovieFavorite(movieId: movieId)
    }
    
    func fetchFavoriteMovies() -> [Movie] {
        return localMoviesDataSource.fetchFavoriteMovies()
    }
    
    func fetchFavoriteMoviesCast() -> [Cast] {
        return localMoviesDataSource.fetchFavoriteMovieCasts()
    }
}
