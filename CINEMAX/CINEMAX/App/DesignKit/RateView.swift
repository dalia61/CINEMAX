//
//  StarIconView.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 04/12/2024.
//

import SwiftUI

struct RateView: View {
    var rating: Double
    
    var body: some View {
        HStack (spacing: 4) {
            Image(systemName: "star.fill")
                .frame(width: 14, height: 14)
            Text("\(rating, specifier: "%.1f")")
                .font(.system(size: 12))
                .fontWeight(.semibold)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 6)
        .foregroundColor(.orangeAccent)
        .frame(width: 55, height: 24)
        .background(Color("BorderAccent"))
        .cornerRadius(8)
    }
}

#Preview {
    RateView(rating: 4.5)
}
