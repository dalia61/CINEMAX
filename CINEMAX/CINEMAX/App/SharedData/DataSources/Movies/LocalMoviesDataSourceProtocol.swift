//
//  LocalMoviesDataSource.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 11/12/2024.
//

import Foundation

protocol LocalMoviesDataSourceProtocol {
    func addToFavorites(movie: Movie)
    func removeFromFavorites(movieId: Int)
    func isMovieFavorite(movieId: Int) -> Bool
    func fetchFavoriteMovies() -> [Movie]
}

struct LocalMoviesDataSource: LocalMoviesDataSourceProtocol {
    private let dataManager: DataManagerProtocol
    private let favoritesKey = "favoriteMovies"
    
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
    
    func removeFromFavorites(movieId: Int) {
        var favorites = fetchFavoriteMovies()
        favorites.removeAll { $0.id == movieId }
        saveFavoriteMovies(favorites)
    }
    
    func isMovieFavorite(movieId: Int) -> Bool {
        fetchFavoriteMovies().contains { $0.id == movieId }
    }
    
    func fetchFavoriteMovies() -> [Movie] {
        guard let data = dataManager.data(forKey: favoritesKey) else { return [] }
        do {
            let movies = try JSONDecoder().decode([Movie].self, from: data)
            return movies
        } catch {
            print("Failed to decode favorite movies: \(error)")
            return []
        }
    }
    
    private func saveFavoriteMovies(_ movies: [Movie]) {
        do {
            let data = try JSONEncoder().encode(movies)
            dataManager.saveData(data, forKey: favoritesKey)
        } catch {
            print("Failed to encode favorite movies: \(error)")
        }
    }
}
