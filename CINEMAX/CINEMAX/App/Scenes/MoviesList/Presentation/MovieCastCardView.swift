//
//  MovieCastView.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 31/12/2024.
//

import SwiftUI

struct MovieCastCardView: View {
    let movie: Cast
    let didFavoriteTap: () -> Void
    
    var body: some View {
        HStack(alignment: .center) {
            ZStack(alignment: .topLeading) {
                ImageView(imageURL: movie.posterPath)
                    .frame(width: 125, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                RateView(rating: movie.voteAverage ?? 0)
            }
            .padding([.horizontal, .top], 8)

            VStack(alignment: .leading, spacing: 2) {
                Text(movie.title ?? "")
                    .fontWeight(.semibold)
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)

                DetailsView(
                    imageName: "calendar",
                    text: movie.releaseDate ?? ""
                )

                DetailsView(
                    imageName: "film",
                    text: movie.primaryGenre
                )

                DetailsView(
                    imageName: "medal",
                    text: String(movie.popularity ?? 0)
                )

                Divider()
            }

            FavoriteView(isFavorite: movie.isFavorite, didTap: {
                didFavoriteTap()
            })
        }
    }
}
