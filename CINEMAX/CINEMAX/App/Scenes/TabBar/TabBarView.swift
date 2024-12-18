//
//  TabBarView.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 03/12/2024.
//

import SwiftUI

struct TabBarView: View {
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(Color.darkAccent) // Set the tab bar background color
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.gray // Unselected icon color
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray] // Unselected text color
        
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(Color.blueAccent) // Selected icon color
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(Color.blueAccent)] // Selected text color
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        TabView {
            HomeView(viewModel: HomeViewModel())
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            SearchView(viewModel: SearchViewModel())
                .tabItem {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                }
            FavoritesView(viewModel: FavoritesViewModel())
                .tabItem {
                    HStack {
                        Image(systemName: "heart")
                        Text("Favorites")
                    }
                }
        }
    }
}

#Preview {
    TabBarView()
}
