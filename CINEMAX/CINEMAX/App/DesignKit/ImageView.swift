//
//  MoviePosterView.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 04/12/2024.
//

import SwiftUI

struct ImageView: View {
    var imageURL: String?
    
    var body: some View {
        AsyncImage(url: URL(string: "\(Constants.imageBaseURL)\(imageURL ?? "").jpg")) { phase in
            Group {
                if let image = phase.image {
                    image
                        .resizable()
                        .clipped()
                }
                else if phase.error != nil {
                    Image("CINEMAX")
                        .resizable()
                        .clipped()
                }
                else {
                    ProgressView()
                        .foregroundStyle(.grayAccent)
                }
            }
        }
    }
}

#Preview {
    // Actor Image: Circle shape
    ImageView(imageURL: "iPg0J9UzAlPj1fLEJNllpW9IhGe")
        .frame(width: 40, height: 40)
        .clipShape(Circle())
    
    // Movie Poster Image: Rounded Rectangle shape
    ImageView(imageURL: "wuMc08IPKEatf9rnMNXvIDxqP4W")
        .frame(width: 135, height: 185)
        .clipShape(RoundedRectangle(cornerRadius: 12))
}
