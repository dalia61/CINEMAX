//
//  MovieCollectionViewWrapper.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 14/12/2024.
//

import SwiftUI

struct MovieCollectionViewWrapper: UIViewControllerRepresentable {
    let movies: [Movie]
    
    func makeUIViewController(context: Context) -> UpComingMovieViewController {
        return UpComingMovieViewController(movies: movies)
    }
    
    func updateUIViewController(_ uiViewController: UpComingMovieViewController, context: Context) {
        uiViewController.updateMovies(movies)
    }
}
