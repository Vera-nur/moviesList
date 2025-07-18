//
//  ContentView.swift
//  moviesList
//
//  Created by Vera Nur on 10.07.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject var favoriteViewModel = FavoritesViewModel()
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem{
                    Label("Home Page", systemImage: "house")
                }
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            FavoriteView()
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
        }
        .environmentObject(favoriteViewModel)
    }
}

#Preview {
    ContentView()
}
