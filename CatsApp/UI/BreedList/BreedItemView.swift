//
//  BreedItemView.swift
//  CatsApp
//
//  Created by Cecile on 08/09/2023.
//

import SwiftUI

struct BreedItemView: View {

    let breed: Breed

    var body: some View {
        if let name = breed.name {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(name)
                            .font(.title3)
                            .foregroundColor(.black)

                        if let altNames = breed.altNames, !altNames.isEmpty {
                            Text(altNames)
                                .font(.body)
                                .italic()
                                .foregroundColor(.gray)
                                .lineLimit(1)
                        }

                        if let origin = breed.origin {
                            Text(origin)
                                .font(.caption)
                                .fontWeight(.light)
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.black)
                                .lineLimit(2)
                        }
                    }

                    Spacer()

                    Image(systemName: "chevron.right")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 12)
                        .foregroundColor(.black)
                }

                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)
            }
        }
    }

}

struct BreedItemViea_Previews: PreviewProvider {
    static var previews: some View {
        BreedItemView(breed: Breed.mockedData)
    }
}
