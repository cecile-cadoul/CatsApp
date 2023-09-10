//
//  ImageService.swift
//  CatsApp
//
//  Created by Cecile on 10/09/2023.
//

import Foundation
import RealmSwift

final class ImageService {

    private var remoteRepository: ImageRemoteRepository
    private var localRepository: LocalRepository

    init(remoteRepository: ImageRemoteRepository, localRepository: LocalRepository) {
        self.remoteRepository = remoteRepository
        self.localRepository = localRepository
    }

    @MainActor
    func fetchBreedImages(breed: Breed, limitOfImage: Int, pageId: Int,
                          includeBreeds: Bool, imageSize: String) async throws {
        let images = try await self.remoteRepository.getImages(limitOfImage: limitOfImage,
                                                               pageId: pageId,
                                                               breedIds: breed.id,
                                                               includeBreeds: includeBreeds,
                                                               imageSize: imageSize)

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
