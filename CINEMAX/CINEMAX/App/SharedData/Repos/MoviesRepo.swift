//
//  MoviesRepo.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 12/12/2024.
//

import Foundation

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

    func fetchUpcoming(completion: @escaping (Result<MoviesListResponse, NetworkError>) -> Void) {
        remoteMoviesDataSource.fetchUpcoming(completion: completion)
    }
    
    func fetchMostPopular(completion: @escaping (Result<MoviesListResponse, NetworkError>) -> Void) {
        remoteMoviesDataSource.fetchMostPopular(completion: completion)
    }
    
    func fetchAllActors(completion: @escaping (Result<ActorsListResponse, NetworkError>) -> Void) {
        remoteMoviesDataSource.fetchActors(completion: completion)
    }
    
    func searchMovie(
        movieName: String,
        completion: @escaping (Result<MoviesListResponse, NetworkError>) -> Void
    ) {
        remoteMoviesDataSource.searchMovie(movieName: movieName, completion: completion)
    }

    func searchActor(
        actorName: String,
        completion: @escaping (Result<ActorsListResponse, NetworkError>) -> Void
    ){
        remoteMoviesDataSource.searchActor(actorName: actorName, completion: completion)

    }
    
    func fetchMovieDetails(
        movieID: Int,
        completion: @escaping (Result<MovieDetails, NetworkError>) -> Void
    ) {
        remoteMoviesDataSource.fetchMovieDetails(movieID: movieID, completion: completion)
    }
    
    func fetchMovieCast(
        movieID: Int,
        completion: @escaping (Result<MovieCastResponse, NetworkError>) -> Void
    ) {
        remoteMoviesDataSource.fetchMovieCast(movieID: movieID, completion: completion)
    }

    func fetchRelatedMovies(movieID: Int, completion: @escaping (Result<MoviesListResponse, NetworkError>) -> Void) {
        remoteMoviesDataSource.fetchRelatedMovies(movieID: movieID, completion: completion)
    }
    
    func fetchActorRelatedMovies(actorID: Int, completion: @escaping (Result<ActorRelatedMoviesResponse, NetworkError>) -> Void) {
        remoteMoviesDataSource.fetchActorRelatedMovies(actorID: actorID, completion: completion)
    }
    
    func fetchActorDetails(
        actorID: Int,
        completion: @escaping (Result<ActorDetails, NetworkError>) -> Void
    ) {
        remoteMoviesDataSource.fetchActorDetails(actorID: actorID, completion: completion)
    }

    func addToFavorites(movie: Movie) {
        localMoviesDataSource.addToFavorites(movie: movie)
    }
    
    func removeFromFavorites(movieId: Int) {
        localMoviesDataSource.removeFromFavorites(movieId: movieId)
    }
    
    func isMovieFavorite(movieId: Int) -> Bool {
        localMoviesDataSource.isMovieFavorite(movieId: movieId)
    }
    
    func fetchFavoriteMovies() -> [Movie] {
        localMoviesDataSource.fetchFavoriteMovies()
    }
}
