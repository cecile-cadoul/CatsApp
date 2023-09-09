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
    func fetchBreeds(limitOfBreed: Int, pageId: Int) async throws {
        let breeds = try await self.remoteRepository.getBreeds(limitOfBreed: limitOfBreed, pageId: pageId)

        if breeds.isEmpty {
            throw DataError.emptyData
        }
        self.localRepository.saveData(data: breeds)
    }

    @MainActor
    func deleteBreeds(breeds: [Breed]) {
        self.localRepository.deleteData(data: breeds)
    }

}
