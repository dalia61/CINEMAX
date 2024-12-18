//
//  ActorCardView.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 16/12/2024.
//

import SwiftUI

public struct ActorCardView: View {
    let actor: MovieCast
    
    public var body: some View {
        HStack(alignment: .center) {
            ZStack(alignment: .topLeading) {
                ImageView(imageURL: actor.profilePath)
                    .frame(width: 125, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(actor.name ?? "")
                    .fontWeight(.semibold)
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)

                DetailsView(
                    imageName: "film",
                    text: actor.knownForDepartment ?? ""
                )

                DetailsView(
                    imageName: "network",
                    text: actor.knownFor?.first?.originCountry?[0] ?? "Unknown"
                )

                DetailsView(
                    imageName: "medal",
                    text: String(actor.popularity ?? 0)
                )
                
                Divider()
            }
        }
    }
}
