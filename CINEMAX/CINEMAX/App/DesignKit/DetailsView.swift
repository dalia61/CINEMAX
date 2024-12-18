//
//  DetailsView.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 09/12/2024.
//

import SwiftUI

struct DetailsView: View {
    let imageName: String
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .foregroundColor(.grayAccent)
            
            Text(text)
                .fontWeight(.medium)
                .font(.system(size: 12))
                .foregroundColor(.grayAccent)
        }
        .padding(.top, 5)
    }
}

#Preview {
    DetailsView(imageName: "calendar", text: "calendar")
}
