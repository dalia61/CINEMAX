//
//  NavigationBarView.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 04/12/2024.
//

import SwiftUI

struct NavigationBarView: View {
    var title: String
    var onDismiss: () -> Void

    var body: some View {
        HStack {
            Button(action: {
                onDismiss()
            }) {
                Image(systemName: "chevron.backward")
                    .foregroundColor(.white)
            }
            .frame(width: 32, height: 32)
            .background(Color("SoftAccent"))
            .cornerRadius(8)
            
            Spacer()
            
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
            
            Spacer()
        }
    }
}
