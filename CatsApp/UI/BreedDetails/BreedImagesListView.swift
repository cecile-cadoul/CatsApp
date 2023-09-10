//
//  BreedImagesListView.swift
//  CatsApp
//
//  Created by Cecile on 10/09/2023.
//

import SwiftUI

struct BreedImagesListView: View {

    @StateObject private var viewModel: BreedDetailsViewModel
    @State private var hasAppeared = false

    private let gridColumns = Array(repeating: GridItem(.flexible(minimum: 120), spacing: 2),
                                    count: 3)

    init(breed: Breed) {
        self._viewModel = StateObject(wrappedValue: BreedDetailsViewModel(breed: breed))
    }

    var body: some View {
        ZStack(alignment: .center) {
            if viewModel.isLoading {
                ProgressView()
            } else {
                LazyVGrid(columns: gridColumns, spacing: 2) {
                    ForEach(viewModel.breed.images, id: \.id) { image in
                        if let url = URL(string: image.url ?? "") {
                            AsyncImage(url: url, content: { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 120, height: 120)
                                    .clipped()
                            }, placeholder: {
                                ProgressView()
                                    .frame(width: 120, height: 120)
                            })
                            .background(Color.gray)
                            .frame(width: 120, height: 120)
                            .onAppear {
                                if viewModel.hasReachedEnd(of: image) {
                                    Task {
                                        await viewModel.fetchNextImages()
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width - Constants.DefaultPadding.horizontal * 2)
        .task {
            if !hasAppeared {
                await viewModel.fetchImages()
                hasAppeared = true
            }
        }
        .alert(isPresented: $viewModel.showError,
               error: viewModel.error) {
            Button("RETRY") {
                Task {
                    await viewModel.fetchImages()
                }
            }
        }
    }

}

struct BreedImagesListView_Previews: PreviewProvider {
    static var previews: some View {
        BreedImagesListView(breed: Breed.mockedData)
    }
}
