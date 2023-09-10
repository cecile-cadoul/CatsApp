//
//  LocalRepository.swift
//  CatsApp
//
//  Created by Cecile on 08/09/2023.
//

import Foundation

protocol LocalRepository {

    func saveData<T>(data: [T])
    func deleteData<T>(data: [T])

    func addImages(to breed: Breed, images: [BreedImage])
    func deleteImages(to breed: Breed)

    func filterBreeds(searchKey: String)

}
