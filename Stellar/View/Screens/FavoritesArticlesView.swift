//
//  FavoritesArticlesView.swift
//  Stellar
//
//  Created by Elliot Knight on 27/07/2022.
//

import SwiftUI

struct FavoritesArticlesView: View {
	@StateObject private var favoriteVM = FavoriteViewModel()	
	var body: some View {
		NavigationView {
			VStack {
				switch favoriteVM.favoriteArticles.isEmpty {
				case true:
					EmptyView()
				default:

					FavoritesListView()
				}
			}
			.navigationTitle("navigationTitle_favorites")
		}
	}
}

struct FavoritesArticlesView_Previews: PreviewProvider {
	static var previews: some View {
		FavoritesArticlesView()
			.environmentObject(FavoriteViewModel())
			.environmentObject(FetchArticlesViewModel())
	}
}

