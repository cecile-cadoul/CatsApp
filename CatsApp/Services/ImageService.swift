//
//  ImageService.swift
//  CatsApp
//
//  Created by Cecile on 10/09/2023.
//

import Foundation
import RealmSwift

final class ImageService {

    private var remoteRepository: RemoteRepository
    private var localRepository: LocalRepository

    init(remoteRepository: RemoteRepository, localRepository: LocalRepository) {
        self.remoteRepository = remoteRepository
        self.localRepository = localRepository
    }

    @MainActor
    func fetchBreedImages(breed: Breed, limitOfImage: Int, pageId: Int,
                          includeBreeds: Bool, imageSize: String) async throws {
        let parameters: [String: Any] = ["limit": limitOfImage,
                                         "page": pageId,
                                         "breed_ids": breed.id,
                                         "include_breeds": includeBreeds,
                                         "size": imageSize,
                                         "order": "DESC"]
        let images = try await self.remoteRepository.fetchData(type: [BreedImage].self, parameters: parameters)

        if images.isEmpty {
            throw DataError.emptyData
        }

        self.localRepository.addImages(to: breed, images: images)
    }

    @MainActor
    func deleteBreedImages(to breed: Breed) {
        self.localRepository.deleteImages(to: breed)
    }

}
