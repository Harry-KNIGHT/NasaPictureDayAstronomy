//
//  RowCell.swift
//  Stellar
//
//  Created by Elliot Knight on 30/08/2022.
//

import SwiftUI
import StellarMoonKit

struct RowCell: View {
	let article: AstronomyArticleModel
	let size: CGFloat = 90
	let isInFavoriteListView: Bool

	var body: some View {
		HStack(alignment: .center, spacing: 10) {
			if article.mediaType == .image {
				if isInFavoriteListView {
					AstronomyImageListCell(article: article)
						.frame(width: 90, height: 90)
						.cornerRadius(10)
				} else {
					AstronomyImageListCell(article: article)
				}
			} else {
				VideoPlaceHolderCell(article: article)
			}
			VStack(alignment: .leading, spacing: 3) {
				Text(article.title)
					.font(.body)
					.fontWeight(.semibold)
					.foregroundColor(.primary)
					.lineLimit(1)
					.accessibilityLabel(article.title)
				Text(article.date)
					.font(.callout)
					.foregroundColor(.secondary)
				Text(article.explanation.trimmingCharacters(in: .whitespacesAndNewlines))
					.font(.body)
					.foregroundColor(.secondary)
					.lineLimit(2)
					.accessibilityHidden(true)
			}
			.multilineTextAlignment(.leading)
			Spacer()
		}
	}
}

struct RowCell_Previews: PreviewProvider {
	static var previews: some View {
		RowCell(article: .astronomySample, isInFavoriteListView: false)
			.previewLayout(.sizeThatFits)
		RowCell(article: .astronomySample, isInFavoriteListView: true)
			.previewLayout(.sizeThatFits)
			.preferredColorScheme(.dark)
	}
}
