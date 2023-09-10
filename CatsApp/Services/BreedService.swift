//
//  BreedService.swift
//  CatsApp
//
//  Created by Cecile on 08/09/2023.
//

import Foundation

final class BreedService {

    private var remoteRepository: BreedRemoteRepository
    private var localRepository: LocalRepository

    init(remoteRepository: BreedRemoteRepository, localRepository: LocalRepository) {
        self.remoteRepository = remoteRepository
        self.localRepository = localRepository
    }

    @MainActor
    func fetchBreeds(limitOfBreed: Int, pageId: Int, searchKey: String) async throws {
        let breeds = try await self.remoteRepository.getBreeds(limitOfBreed: limitOfBreed, pageId: pageId)

        if breeds.isEmpty {
            throw DataError.emptyData
        }
        if !searchKey.isEmpty {
            self.filterBreeds(searchKey: searchKey) // We use the search key to init the filtration state
        } else {
            self.localRepository.saveData(data: breeds)
        }
    }

    @MainActor
    func deleteBreeds(breeds: [Breed]) {
        self.localRepository.deleteData(data: breeds)
    }

}

// MARK: - Filtration Extension

extension BreedService {

    @MainActor
    func filterBreeds(searchKey: String) {
        self.localRepository.filterBreeds(searchKey: searchKey)
    }

}
