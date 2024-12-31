//
//  EmptyStateView.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 31/12/2024.
//

import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack {
            Spacer()
            Image("Empty")
                .resizable()
                .frame(width: 100, height: 100)

            Text("No Results Found")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    EmptyStateView()
        .background(Color.darkAccent)
}
