//
//  LocalMoviesDataSource.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 11/12/2024.
//

import Foundation

protocol LocalMoviesDataSourceProtocol {
    func addToFavorites(movie: Movie)
    func addToFavorites(movieCast: Cast)
    func removeMovieFromFavorites(movieId: Int)
    func removeMovieCastFromFavorites(movieId: Int)
    func isMovieFavorite(movieId: Int) -> Bool
    func fetchFavoriteMovies() -> [Movie]
    func fetchFavoriteMovieCasts() -> [Cast]
}

struct LocalMoviesDataSource: LocalMoviesDataSourceProtocol {
    private let dataManager: DataManagerProtocol
    private let favoriteMoviesKey = "favoriteMovies"
    private let favoriteCastsKey = "favoriteCasts"
    
    public init(dataManager: DataManagerProtocol = UserDefaultsManager()) {
        self.dataManager = dataManager
    }
    
    func addToFavorites(movie: Movie) {
        var favorites = fetchFavoriteMovies()
        if !favorites.contains(where: { $0.id == movie.id }) {
            favorites.append(movie)
            saveFavoriteMovies(favorites)
        }
    }
    
    func addToFavorites(movieCast: Cast) {
        var favorites = fetchFavoriteMovieCasts()
        if !favorites.contains(where: { $0.id == movieCast.id }) {
            favorites.append(movieCast)
            saveFavoriteMovieCasts(favorites)
        }
    }
    
    func removeMovieFromFavorites(movieId: Int) {
        var favorites = fetchFavoriteMovies()
        favorites.removeAll { $0.id == movieId }
        saveFavoriteMovies(favorites)
    }
    
    func removeMovieCastFromFavorites(movieId: Int) {
        var castFavorites = fetchFavoriteMovieCasts()
        castFavorites.removeAll { $0.id == movieId }
        saveFavoriteMovieCasts(castFavorites)
    }
    
    func isMovieFavorite(movieId: Int) -> Bool {
        return fetchFavoriteMovies().contains { $0.id == movieId } || fetchFavoriteMovieCasts().contains { $0.id == movieId }
    }
    
    func fetchFavoriteMovies() -> [Movie] {
        guard let data = dataManager.data(forKey: favoriteMoviesKey) else { return [] }
        do {
            let movies = try JSONDecoder().decode([Movie].self, from: data)
            return movies
        } catch {
            print("Failed to decode favorite movies: \(error)")
            return []
        }
    }
    
    func fetchFavoriteMovieCasts() -> [Cast] {
        guard let data = dataManager.data(forKey: favoriteCastsKey) else { return [] }
        do {
            let casts = try JSONDecoder().decode([Cast].self, from: data)
            return casts
        } catch {
            print("Failed to decode favorite movie casts: \(error)")
            return []
        }
    }
    
    private func saveFavoriteMovies(_ movies: [Movie]) {
        do {
            let data = try JSONEncoder().encode(movies)
            dataManager.saveData(data, forKey: favoriteMoviesKey)
        } catch {
            print("Failed to encode favorite movies: \(error)")
        }
    }
    
    private func saveFavoriteMovieCasts(_ casts: [Cast]) {
        do {
            let data = try JSONEncoder().encode(casts)
            dataManager.saveData(data, forKey: favoriteCastsKey)
        } catch {
            print("Failed to encode favorite movie casts: \(error)")
        }
    }
}
