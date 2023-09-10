//
//  MockLocalRepository.swift
//  CatsAppTests
//
//  Created by Cecile on 09/09/2023.
//

import Foundation
@testable import CatsApp

final class MockLocalRepository: LocalRepository {
    func filterBreeds(searchKey: String) {

    }

    func saveData<T>(data: [T]) {

    }

    func deleteData<T>(data: [T]) {

    }

    func addImages(to breed: Breed, images: [BreedImage]) {

    }

    func deleteImages(to breed: Breed) {

    }

}
