//
//  BreedDetailsView.swift
//  CatsApp
//
//  Created by Cecile on 10/09/2023.
//

import SwiftUI

struct BreedDetailsView: View {

    let breed: Breed

    var body: some View {
        if let name = breed.name {
            ScrollView {
                VStack(alignment: .leading, spacing: 5) {
                    if let altsNames = breed.altNames, !altsNames.isEmpty {
                        Text(altsNames)
                            .font(.body)
                            .italic()
                            .fontWeight(.medium)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.leading)
                    }

                    if let origin = breed.origin, !origin.isEmpty {
                        Text(origin)
                            .font(.body)
                            .padding(.bottom, 10)
                    }

                    if let description = breed.breedDescription, !description.isEmpty {
                        Text("DESCRITION_TITLE")
                            .font(.title3)
                            .fontWeight(.medium)

                        Text(description)
                            .font(.body)
                            .fontWeight(.light)
                            .multilineTextAlignment(.leading)
                    }

                    BreedImagesListView(breed: breed)
                        .padding(.top, 10)

                    Spacer()
                }
                .padding(.horizontal, Constants.DefaultPadding.horizontal)
            }
            .navigationTitle(name)
        }
    }

}

struct BreedDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        BreedDetailsView(breed: Breed.mockedData)
    }
}
