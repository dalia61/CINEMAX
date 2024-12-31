//
//  RelatedMoviesSectionView.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 17/12/2024.
//

import Foundation
import SwiftUI

struct RelatedMoviesSectionView: View {
    let movies: [Cast]
    let onMovieSelected: (Cast) -> Void
    let onMovieFavorite: (Int) -> Void

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(movies.indices) { index in
                    Button(action: {
                        onMovieSelected(movies[index]) },
                           label: {
                        makeMovieCardView(movie: movies[index], index: index)
                    })
                }
            }
        }
    }

    private func makeMovieCardView(movie: Cast, index: Int) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .top) {
                ImageView(imageURL: movie.posterPath)
                    .frame(height: 180)

                HStack {
                    FavoriteView(isFavorite: movie.isFavorite, didTap: {
                        onMovieFavorite(index)
                    })
                    Spacer()
                    RateView(rating: movie.voteAverage ?? 0)
                }
                .padding([.horizontal, .top], 8)
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(movie.title ?? "")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
                    .lineLimit(1)
                Text(movie.primaryGenre)
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(.gray)
            }
            .padding([.horizontal, .bottom], 8)
        }
        .background(Color.darkAccent)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .frame(width: 140, height: 230)
    }
}
