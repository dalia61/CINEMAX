//
//  SeeAllView.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 04/12/2024.
//

import SwiftUI

struct SectionHeaderView: View {
    var title: String
    var buttonTitle: String? = nil
    var buttonAction: (() -> Void)? = nil
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)

            Spacer()

            if let buttonTitle, let buttonAction {
                Button(action: buttonAction) {
                    Text(buttonTitle)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.blueAccent)
                }
            }
        }
    }
}

#Preview {
    SectionHeaderView(title: "Most Popular", buttonTitle: "See All", buttonAction: {})
        .background(Color.darkAccent)
}
