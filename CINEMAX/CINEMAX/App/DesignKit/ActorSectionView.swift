//
//  ActorListSectionView.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 09/12/2024.
//

import SwiftUI

struct ActorSectionView: View {
    let actors: [MovieCast]
    let onActorSelected: (MovieCast) -> Void

    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 8) {
                    ForEach(actors) { actor in
                        Button(action: { onActorSelected(actor) }, label: {
                            makeActorCardView(actor: actor)
                        })
                    }
                }
            }
        }
    }
    
    func makeActorCardView(actor: MovieCast) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                ImageView(imageURL: actor.profilePath)
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(actor.name ?? "")
                        .foregroundStyle(.white)
                        .font(.system(size: 16, weight: .semibold))
                        .lineLimit(1)
                    Text(actor.knownForDepartment ?? "")
                        .foregroundStyle(.gray)
                        .font(.system(size: 12, weight: .medium))
                        .lineLimit(1)
                }
            }
            .background(Color.darkAccent)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}
