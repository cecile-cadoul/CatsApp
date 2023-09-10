//
//  BreedImagesListView.swift
//  CatsApp
//
//  Created by Cecile on 10/09/2023.
//

import SwiftUI
import NukeUI

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
                            LazyImage(url: url) { state in
                                if let image = state.image {
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 120, height: 120)
                                        .clipped()
                                } else if state.error != nil {
                                    Image(systemName: "multiply.circle.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height:14)
                                        .foregroundColor(.red)
                                } else {
                                    ProgressView()
                                        .frame(width: 120, height: 120)
                                }
                            }
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
