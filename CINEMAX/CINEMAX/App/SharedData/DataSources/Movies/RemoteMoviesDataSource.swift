//
//  RemoteMoviesDataSource.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 11/12/2024.
//

import Combine

protocol RemoteMoviesDataSourceProtocol {
    func fetchUpcoming() -> AnyPublisher<MoviesListResponse, NetworkError>
    func fetchMostPopular() -> AnyPublisher<MoviesListResponse, NetworkError>
    func fetchActors() -> AnyPublisher<ActorsListResponse, NetworkError>
    func searchMovie(movieName: String) -> AnyPublisher<MoviesListResponse, NetworkError>
    func searchActor(actorName: String) -> AnyPublisher<ActorsListResponse, NetworkError>
    func fetchMovieDetails(movieID: Int) -> AnyPublisher<MovieDetails, NetworkError>
    func fetchMovieCast(movieID: Int) -> AnyPublisher<MovieCastResponse, NetworkError>
    func fetchRelatedMovies(movieID: Int) -> AnyPublisher<MoviesListResponse, NetworkError>
    func fetchActorRelatedMovies(actorID: Int) -> AnyPublisher<ActorRelatedMoviesResponse, NetworkError>
    func fetchActorDetails(actorID: Int) -> AnyPublisher<ActorDetails, NetworkError>
}

struct RemoteMoviesDataSource: RemoteMoviesDataSourceProtocol {
    private let networkingManger: NetworkManagerProtocol

    public init(networkingManger: NetworkManagerProtocol = NetworkManager()) {
        self.networkingManger = networkingManger
    }

    func fetchUpcoming() -> AnyPublisher<MoviesListResponse, NetworkError> {
        let endpoint = MoviesEndpoint.upcoming
        return networkingManger.request(using: endpoint)
    }

    func fetchMostPopular() -> AnyPublisher<MoviesListResponse, NetworkError> {
        let endpoint = MoviesEndpoint.mostPopular
        return networkingManger.request(using: endpoint)
    }

    func fetchActors() -> AnyPublisher<ActorsListResponse, NetworkError> {
        let endpoint = MoviesEndpoint.allActors
        return networkingManger.request(using: endpoint)
    }

    func searchMovie(movieName: String) -> AnyPublisher<MoviesListResponse, NetworkError> {
        let endpoint = MoviesEndpoint.searchMovies(movieName: movieName)
        return networkingManger.request(using: endpoint)
    }
    
    func searchActor(actorName: String) -> AnyPublisher<ActorsListResponse, NetworkError> {
        let endpoint = MoviesEndpoint.searchActors(actorName: actorName)
        return networkingManger.request(using: endpoint)
    }

    func fetchMovieDetails(movieID: Int) -> AnyPublisher<MovieDetails, NetworkError> {
        let endpoint = MoviesEndpoint.movieDetails(movieID: movieID)
        return networkingManger.request(using: endpoint)
    }

    func fetchMovieCast(movieID: Int) -> AnyPublisher<MovieCastResponse, NetworkError> {
        let endpoint = MoviesEndpoint.movieCast(movieID: movieID)
        return networkingManger.request(using: endpoint)
    }

    func fetchRelatedMovies(movieID: Int) -> AnyPublisher<MoviesListResponse, NetworkError> {
        let endpoint = MoviesEndpoint.relatedMovies(movieID: movieID)
        return networkingManger.request(using: endpoint)
    }

    func fetchActorRelatedMovies(actorID: Int) -> AnyPublisher<ActorRelatedMoviesResponse, NetworkError> {
        let endpoint = MoviesEndpoint.ActorRelatedMovies(actorID: actorID)
        return networkingManger.request(using: endpoint)
    }
    
    func fetchActorDetails(actorID: Int) -> AnyPublisher<ActorDetails, NetworkError> {
        let endpoint = MoviesEndpoint.actordetails(actorID: actorID)
        return networkingManger.request(using: endpoint)
    }
}
