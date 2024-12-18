//
//  MoviesRepoProtocol.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 13/12/2024.
//

import Foundation

protocol MoviesRepoProtocol {
    func fetchUpcoming(completion: @escaping (Result<MoviesListResponse, NetworkError>) -> Void)
    func fetchMostPopular(completion: @escaping (Result<MoviesListResponse, NetworkError>) -> Void)
    func fetchAllActors(completion: @escaping (Result<ActorsListResponse, NetworkError>) -> Void)
    func searchMovie(movieName: String,completion: @escaping (Result<MoviesListResponse, NetworkError>) -> Void)
    func searchActor(actorName: String,completion: @escaping (Result<ActorsListResponse, NetworkError>) -> Void)
    func fetchMovieDetails(movieID: Int,completion: @escaping (Result<MovieDetails, NetworkError>) -> Void)
    func fetchMovieCast(movieID: Int,completion: @escaping (Result<MovieCastResponse, NetworkError>) -> Void)
    func fetchRelatedMovies(movieID: Int,completion: @escaping (Result<MoviesListResponse, NetworkError>) -> Void)
    func fetchActorRelatedMovies(actorID: Int,completion: @escaping (Result<ActorRelatedMoviesResponse, NetworkError>) -> Void)
    func fetchActorDetails(actorID: Int,completion: @escaping (Result<ActorDetails, NetworkError>) -> Void)
    func addToFavorites(movie: Movie)
    func removeFromFavorites(movieId: Int)
    func isMovieFavorite(movieId: Int) -> Bool
    func fetchFavoriteMovies() -> [Movie]
}
