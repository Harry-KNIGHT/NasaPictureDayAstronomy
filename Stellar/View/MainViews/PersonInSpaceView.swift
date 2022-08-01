//
//  PeopleInSpaceView.swift
//  Stellar
//
//  Created by Elliot Knight on 28/07/2022.
//

import SwiftUI

struct PersonInSpaceView: View {
	@EnvironmentObject public var peopleApi: PersonInSpaceApi
	var body: some View {
		NavigationView {
			ScrollView {
				LazyVStack(alignment: .leading) {
					ForEach(peopleApi.spacePeoples, id: \.self) { p in
						ForEach(p.people, id: \.self) { person in
							NavigationLink(destination: PersonSpaceDetailView(personInSpace: person)) {
								ZStack {
									RoundedRectangle(cornerRadius: 10)
										.frame(maxWidth: .infinity, maxHeight: .infinity)
										.foregroundStyle(.regularMaterial)
									if person.agency.lowercased() == "nasa" {

										PersonInSpaceRow(name: person.name, agency: person.agency, position: person.position, image: "NASAL")

									} else if person.agency.lowercased() == "roscosmos" {

										PersonInSpaceRow(name: person.name, agency: person.agency, position: person.position, image: "ROSCOSMOSL")

									} else if person.agency.lowercased() == "esa" {

										PersonInSpaceRow(name: person.name, agency: person.agency, position: person.position, image: "ESAL", imageHeight: 30)

									} else if person.agency.lowercased() == "cnsa" {

										PersonInSpaceRow(name: person.name, agency: person.agency, position: person.position, image: "CNSAL", corner: 10)

									} else {
										PersonInSpaceRow(hasGotImage: false, name: person.name, agency: person.agency, position: person.position, image: "")
									}
								}
							}
						}
					}
				}
				.padding()
				.navigationTitle("Currently in space")
			}
		}
		.task {
			do {
				try await peopleApi.fetchPersonInSpace()
			} catch {
				print("Error append, \(error.localizedDescription)")
			}
		}

	}
}

struct PersonInSpaceView_Previews: PreviewProvider {
	static var previews: some View {
		PersonInSpaceView()
			.environmentObject(PersonInSpaceApi())
	}
}

struct PersonInSpaceRow: View {
	var hasGotImage: Bool = true
	var name: String
	var agency: String
	var position: String
	var image: String
	var imageHeight: CGFloat = 60
	var corner: CGFloat = 0

	var body: some View {
		if hasGotImage {
			HStack {
				VStack(alignment: .leading) {
					Text(name)
						.font(.title3)
						.foregroundColor(.primary)
					Text(agency)
						.foregroundColor(.primary)
						.font(.headline)
					Text(position)
						.font(.subheadline)
						.foregroundColor(.secondary)
				}.padding(.vertical)
				Spacer()
				Image(image)
					.resizable()
					.scaledToFit()
					.frame(height: imageHeight)
					.clipShape(RoundedRectangle(cornerRadius: corner, style: .continuous))
			}.padding(.horizontal, 8)
		}else {
				VStack(alignment: .leading) {
					Text(name)
						.font(.title3)
						.foregroundColor(.primary)
					Text(agency)
						.foregroundColor(.primary)
						.font(.headline)
					Text(position)
						.font(.subheadline)
						.foregroundColor(.secondary)
				}
				.padding()
			}
		}
}
