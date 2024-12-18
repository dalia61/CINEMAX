//
//  HeartIconView.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 04/12/2024.
//

import SwiftUI

struct FavoriteView: View {
    @State var isFavorite: Bool
    let didTap: () -> Void

    var body: some View {
        Button(action: {
            isFavorite.toggle()
            didTap()
        }) {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .foregroundColor(.red)
                .padding(4)
        }
        .frame(width: 24, height: 24)
        .background(Color("BorderAccent"))
        .cornerRadius(8)
    }
}
