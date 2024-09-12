//
//  FavoritesListView.swift
//  Stellar
//
//  Created by Elliot Knight on 30/11/2022.
//

import SwiftUI

struct FavoritesListView: View {
	@StateObject public var favoriteVM = FavoriteViewModel()

	var body: some View {
		List {
			ForEach(favoriteVM.favoriteArticles) { article in
				NavigationLink(destination: ArticleDetailView(article: article)) {
					RowCell(article: article, isInFavoriteListView: true)
				}
			}
			.onDelete(perform: favoriteVM.deletFavorite)
			.onMove(perform: favoriteVM.moveFavorite)
		}
		.toolbar {
			ToolbarItem(placement: .navigationBarLeading) {
				EditButton()
			}
		}
	}
}

struct FavoritesListView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesListView()
			.environmentObject(FavoriteViewModel())
    }
}
