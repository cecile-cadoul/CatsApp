//
//  BreedsListView.swift
//  CatsApp
//
//  Created by Cecile on 08/09/2023.
//

import SwiftUI

struct BreedsListView: View {

    @StateObject private var viewModel = BreedListViewModel()
    @State private var hasAppeared = false
    @State private var breedKeyword: String = ""

    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                NavigationView {
                    ScrollView {
                        LazyVStack(spacing: 10) {
                            ForEach(viewModel.breeds, id: \.id) { breed in
                                NavigationLink {

                                } label: {
                                    BreedItemView(breed: breed)
                                        .task {
                                            if viewModel.hasReachedEnd(of: breed) {
                                                await viewModel.fetchNextBreeds()
                                            }
                                        }
                                }
                            }
                        }
                        .padding()
                    }
                    .navigationBarTitleDisplayMode(.automatic)
                    .navigationTitle("CATS_BREEDS_TITLE")
                }
            }
        }
        .task {
            if !hasAppeared {
                await viewModel.fetchBreeds()
                hasAppeared = true
            }
        }
        .alert(isPresented: $viewModel.showError,
               error: viewModel.error) {
            Button("RETRY") {
                Task {
                    await viewModel.fetchBreeds()
                }
            }
        }
    }

}

struct BreedsListView_Previews: PreviewProvider {
    static var previews: some View {
        BreedsListView()
    }
}
