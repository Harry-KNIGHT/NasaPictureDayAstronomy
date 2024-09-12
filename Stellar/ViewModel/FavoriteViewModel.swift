//
//  FavoriteViewModel.swift
//  Stellar
//
//  Created by Elliot Knight on 27/07/2022.
//

import Foundation
import StellarMoonKit

class FavoriteViewModel: ObservableObject {
	@Published var favoriteArticles: [Article]

	init() {
		if let data = UserDefaults.standard.data(forKey: "SavedFavoritesData") {
			if let decoded = try? JSONDecoder().decode([Article].self, from: data) {
				favoriteArticles = decoded
				return
			}
		}
		// No Saved data
		favoriteArticles = []
	}

	private func save() {
		if let encoded = try? JSONEncoder().encode(favoriteArticles) {
			UserDefaults.standard.set(encoded, forKey: "SavedFavoritesData")
		}
	}

	// MARK: Private methods

	/// Add article to favorite
	/// - Parameter article: Article is from NasaAstronomy model
	private func addToFavorite(article: Article) {
		self.favoriteArticles.insert(article, at: 0)
	}

	private func isArticleIsInFavorites(_ article: Article) -> Bool {
		return self.favoriteArticles.contains(article)
	}

	/// Delet Favorite from list swipe
	/// - Parameter offsets: offset permit to delet article with swipe gesture 
	func deletFavorite(at offsets: IndexSet) {
		favoriteArticles.remove(atOffsets: offsets)
		save()
	}

	/// Delet selected article
	/// - Parameter article: Article is from NasaAstronomy model
	private func deletSelectedFavorite(article: Article) {
		self.favoriteArticles.removeAll { $0.date == article.date }
	}

	// MARK: Public methods

	/// Permit to move index of each article in the array manually.
	/// - Parameters:
	///   - index: From current position
	///   - offset: To final position
	func moveFavorite(from index: IndexSet, to offset: Int) {
		self.favoriteArticles.move(fromOffsets: index, toOffset: offset)
		save()
	}

	/// Add or delet article if it's on array yet or no.
	/// - Parameter article: Picture, description and copyright.
	func addOrDeletFavorite(article: Article) {
		if self.favoriteArticles.contains(where: { $0.id == article.id }) {
			deletSelectedFavorite(article: article)
			save()
		} else {
			addToFavorite(article: article)
			save()
		}
	}

	func isArticleIsInFavoritesSystemName(_ article: Article) -> String {
		return isArticleIsInFavorites(article) ? "star.fill" : "star"
	}
}
