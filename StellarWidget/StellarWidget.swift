//
//  StellarWidget.swift
//  StellarWidget
//
//  Created by Elliot Knight on 15/05/2023.
//

import WidgetKit
import SwiftUI
import StellarMoonKit

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
		SimpleEntry(date: Date(), article: .imageArticleSample)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
		let entry = SimpleEntry(date: Date(), article: .imageArticleSample)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
		Task {
			do {
				let articlesArray = try await FetchArticlesApi.fetchArticles()
				let todaysArticle = articlesArray[0]
				let entry = SimpleEntry(date: Date(), article: todaysArticle)
				let timeline = Timeline(entries: [entry], policy: .atEnd)
				completion(timeline)
			} catch {
				throw ApiError.badHttpResponse
			}
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
	let article: Article
}

struct StellarWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
		NetworkImage(url: URL(string: entry.article.mediaUrl))
    }
}

struct StellarWidget: Widget {
    let kind: String = "StellarWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            StellarWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Stellar Widget")
        .description("Widget of the day")
    }
}

struct StellarWidget_Previews: PreviewProvider {
    static var previews: some View {
		StellarWidgetEntryView(entry: SimpleEntry(date: Date(), article: .imageArticleSample))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
