//
//  BreedsListView.swift
//  CatsApp
//
//  Created by Cecile on 08/09/2023.
//

import SwiftUI

struct BreedsListView: View {

    @StateObject private var viewModel = BreedListViewModel()
    @State private var hasAppeared: Bool  = false
    @State private var showSuggestion: Bool = false
    @FocusState private var textFieldFocused: Bool

    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                NavigationView {
                    VStack {

                        // MARK: TextField
                        HStack(spacing: 10) {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 16)
                                .foregroundColor(.gray)

                            TextField("SEARCH", text: $viewModel.searchKey, onEditingChanged: { _ in
                                if textFieldFocused {
                                    showSuggestion = false
                                } else {
                                    showSuggestion = true
                                }
                            }, onCommit: {
                                viewModel.filterBreeds()
                            })
                            .focused($textFieldFocused)
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.never)
                            .submitLabel(.search)

                            Button {
                                viewModel.resetFilter()
                            } label: {
                                Image(systemName: "multiply.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 14)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(10)
                        .background(.gray.opacity(0.2))
                        .cornerRadius(15)
                        .padding(.horizontal)

                        // MARK: Suggestions
                        if viewModel.searchKey.count > 1 && showSuggestion {
                            ScrollView {
                                ForEach(viewModel.breeds.where({
                                    $0.name.contains(viewModel.searchKey,
                                                     options: [.diacriticInsensitive,
                                                               .caseInsensitive])
                                }), id: \.self) { breed in
                                    VStack(alignment: .leading) {
                                        if let name = breed.name {
                                            Button {
                                                textFieldFocused = false
                                                viewModel.filterBreeds(breedName: name)
                                            } label: {
                                                Text(name)
                                            }

                                            Divider()
                                        }
                                    }
                                }
                            }
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.horizontal)
                        }

                        // MARK: Breed List
                        ScrollView {
                            LazyVStack(spacing: 10) {
                                ForEach(viewModel.filteredBreeds, id: \.id) { breed in
                                    NavigationLink {
                                        BreedDetailsView(breed: breed)
                                    } label: {
                                        BreedItemView(breed: breed)
                                            .onAppear {
                                                if viewModel.hasReachedEnd(of: breed) {
                                                    Task {
                                                        await viewModel.fetchNextBreeds()
                                                    }
                                                }
                                            }
                                    }
                                }
                            }
                            .padding()
                        }
                    }
                    .navigationBarTitleDisplayMode(.automatic)
                    .navigationTitle("CATS_BREEDS_TITLE")
                }
                .accentColor(.black)
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
