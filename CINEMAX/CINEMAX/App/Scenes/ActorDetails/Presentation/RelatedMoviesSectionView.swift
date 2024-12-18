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

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(movies) { movie in
                    Button(action: { onMovieSelected(movie) },
                           label: {
                        makeMovieCardView(movie: movie)
                    })
                }
            }
        }
    }

    private func makeMovieCardView(movie: Cast) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .top) {
                ImageView(imageURL: movie.posterPath)
                    .frame(height: 180)

                HStack {
                    RateView(rating: movie.voteAverage ?? 0)
                }
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(movie.title ?? "")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
                    .lineLimit(1)
                
            }
        }
        .background(Color.darkAccent)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .frame(width: 140, height: 230)
    }
}
