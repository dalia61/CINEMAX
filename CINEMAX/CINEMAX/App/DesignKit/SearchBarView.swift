//
//  SearchBarView.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 04/12/2024.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String

    var body: some View {
        HStack(spacing: 8){
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.grayAccent)
                    .padding(.leading, 16)
                
                TextField("", text: $text, prompt: Text("Search")
                    .foregroundColor(.grayAccent)
                )
                .foregroundColor(.white)
                .frame(height: 40)
            }
            .background(Color.softAccent)
            .cornerRadius(24)
            
            Button(action: {
                if text.isEmpty {
                    print("Search button tapped")
                } else {
                    text = ""
                }
            }) {
                Text(text.isEmpty ? "" : "Cancel")
                    .foregroundColor(.white)
                    .cornerRadius(24)
            }
        }
        .padding(.horizontal, 16)
    }
}
