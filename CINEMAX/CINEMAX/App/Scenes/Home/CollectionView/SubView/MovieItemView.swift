//
//  MovieItemView.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 14/12/2024.
//

import SwiftUI

struct MovieItemView: View {
    let movie: Movie

    var body: some View {
        VStack {
            ZStack(alignment: .bottomLeading) {
                ImageView(imageURL: movie.posterPath)
                    .frame(width: 300, height: 180)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("\(movie.title ?? "")")
                        .foregroundStyle(.white)
                        .font(.system(size: 16, weight: .semibold))
                    
                    Text("\(movie.releaseDate ?? "")")
                        .foregroundStyle(.gray)
                        .font(.system(size: 12, weight: .medium))
                }
                .padding([.leading, .bottom], 8)
                .background(Color.borderAccent)
            }
        }
        .background(Color.darkAccent)
    }
}
