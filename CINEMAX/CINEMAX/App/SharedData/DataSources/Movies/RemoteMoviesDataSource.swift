//
//  RemoteMoviesDataSource.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 11/12/2024.
//

import Foundation

protocol RemoteMoviesDataSourceProtocol {
    func fetchUpcoming(completion: @escaping (Result<MoviesListResponse, NetworkError>) -> Void)
    func fetchMostPopular(completion: @escaping (Result<MoviesListResponse, NetworkError>) -> Void)
    func fetchActors(completion: @escaping (Result<ActorsListResponse, NetworkError>) -> Void)
    func searchMovie(
        movieName: String,
        completion: @escaping (Result<MoviesListResponse, NetworkError>) -> Void
    )
    func searchActor(
        actorName: String,
        completion: @escaping (Result<ActorsListResponse, NetworkError>) -> Void
    )
    func fetchMovieDetails(
        movieID: Int,
        completion: @escaping (Result<MovieDetails, NetworkError>) -> Void
    )
    func fetchMovieCast(
        movieID: Int,
        completion: @escaping (Result<MovieCastResponse, NetworkError>) -> Void
    )
    func fetchRelatedMovies(
        movieID: Int,
        completion: @escaping (Result<MoviesListResponse, NetworkError>) -> Void
    )
    func fetchActorRelatedMovies(
        actorID: Int,
        completion: @escaping (Result<ActorRelatedMoviesResponse, NetworkError>) -> Void
    )
    func fetchActorDetails(
        actorID: Int,
        completion: @escaping (Result<ActorDetails, NetworkError>) -> Void
    )
}

struct RemoteMoviesDataSource: RemoteMoviesDataSourceProtocol {
    private let networkingManger: NetworkManagerProtocol

    public init(networkingManger: NetworkManagerProtocol = NetworkManager()) {
        self.networkingManger = networkingManger
    }

    func fetchUpcoming(completion: @escaping (Result<MoviesListResponse, NetworkError>) -> Void) {
        let endpoint = MoviesEndpoint.upcoming
        networkingManger.request(
            using: endpoint,
            completion: completion
        )
    }

    func fetchMostPopular(completion: @escaping (Result<MoviesListResponse, NetworkError>) -> Void) {
        let endpoint = MoviesEndpoint.mostPopular
        networkingManger.request(
            using: endpoint,
            completion: completion
        )
    }

    func fetchActors(completion: @escaping (Result<ActorsListResponse, NetworkError>) -> Void) {
        let endpoint = MoviesEndpoint.allActors
        networkingManger.request(
            using: endpoint,
            completion: completion
        )
    }

    func searchMovie(
        movieName: String,
        completion: @escaping (Result<MoviesListResponse, NetworkError>) -> Void
    ) {
        let endpoint = MoviesEndpoint.searchMovies(movieName: movieName)
        networkingManger.request(
            using: endpoint,
            completion: completion
        )
    }
    
    func searchActor(
        actorName: String,
        completion: @escaping (Result<ActorsListResponse, NetworkError>) -> Void
    ) {
            let endpoint = MoviesEndpoint.searchActors(actorName: actorName)
            networkingManger.request(
                using: endpoint,
                completion: completion
            )
    }

    func fetchMovieDetails(
        movieID: Int,
        completion: @escaping (Result<MovieDetails, NetworkError>) -> Void
    ) {
        let endpoint = MoviesEndpoint.movieDetails(movieID: movieID)
        networkingManger.request(
            using: endpoint,
            completion: completion
        )
    }

    func fetchMovieCast(movieID: Int, completion: @escaping (Result<MovieCastResponse, NetworkError>) -> Void) {
        let endpoint = MoviesEndpoint.movieCast(movieID: movieID)
        networkingManger.request(
            using: endpoint,
            completion: completion
        )
    }

    func fetchRelatedMovies(movieID: Int, completion: @escaping (Result<MoviesListResponse, NetworkError>) -> Void) {
        let endpoint = MoviesEndpoint.relatedMovies(movieID: movieID)
        networkingManger.request(
            using: endpoint,
            completion: completion
        )
    }
    func fetchActorRelatedMovies(actorID: Int, completion: @escaping (Result<ActorRelatedMoviesResponse, NetworkError>) -> Void) {
        let endpoint = MoviesEndpoint.ActorRelatedMovies(actorID: actorID)
        networkingManger.request(
            using: endpoint,
            completion: completion
        )
    }
    
    func fetchActorDetails(actorID: Int, completion: @escaping (Result<ActorDetails, NetworkError>) -> Void) {
        let endpoint = MoviesEndpoint.actordetails(actorID: actorID)
        networkingManger.request(
            using: endpoint,
            completion: completion
        )
    }
}
