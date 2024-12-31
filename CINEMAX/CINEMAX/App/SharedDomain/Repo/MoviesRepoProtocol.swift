//
//  MoviesRepoProtocol.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 13/12/2024.
//

import Foundation
import Combine

protocol MoviesRepoProtocol {
    func fetchUpcoming() -> AnyPublisher<MoviesListResponse, NetworkError>
    func fetchMostPopular() -> AnyPublisher<MoviesListResponse, NetworkError>
    func fetchAllActors() -> AnyPublisher<ActorsListResponse, NetworkError>
    func searchMovie(movieName: String) -> AnyPublisher<MoviesListResponse, NetworkError>
    func searchActor(actorName: String) -> AnyPublisher<ActorsListResponse, NetworkError>
    func fetchMovieDetails(movieID: Int) -> AnyPublisher<MovieDetails, NetworkError>
    func fetchMovieCast(movieID: Int) -> AnyPublisher<MovieCastResponse, NetworkError>
    func fetchRelatedMovies(movieID: Int) -> AnyPublisher<MoviesListResponse, NetworkError>
    func fetchActorRelatedMovies(actorID: Int) -> AnyPublisher<ActorRelatedMoviesResponse, NetworkError>
    func fetchActorDetails(actorID: Int) -> AnyPublisher<ActorDetails, NetworkError>
    func addToFavorites(movie: Movie)
    func addToFavorites(movieCast: Cast)
    func removeMovieFromFavorites(movieId: Int)
    func removeMovieCastFromFavorites(movieId: Int)
    func isMovieFavorite(movieId: Int) -> Bool
    func fetchFavoriteMovies() -> [Movie]
    func fetchFavoriteMoviesCast() -> [Cast]
}
