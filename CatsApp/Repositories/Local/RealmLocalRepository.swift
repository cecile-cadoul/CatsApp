//
//  RealmLocalRepository.swift
//  CatsApp
//
//  Created by Cecile on 07/09/2023.
//

import Foundation
import RealmSwift

class RealmLocalRepository: LocalRepository {

    func saveData<T>(data: [T]) {
        do {
            let realm = try Realm()

            guard let dataObject = data as? [Object] else {
                print("❌ RealmLocalRepository.saveData: data does not comform to Object type: \(data)")
                return
            }
            try realm.write {
                realm.add(dataObject, update: .modified)
            }
        } catch let error as NSError {
            print("❌ RealmLocalRepository.saveData: Failed to save breeds: \(error)")
        }
    }

    func deleteData<T>(data: [T]) {
        do {
            let realm = try Realm()

            guard let dataObject = data as? [Object] else {
                print("❌ RealmLocalRepository.deleteData: data does not comform to Object type: \(data)")
                return
            }
            try realm.write {
                realm.delete(dataObject)
            }
        } catch let error as NSError {
            print("❌ RealmLocalRepository.deleteData: Failed to delete data: \(error)")
        }
    }

}

// MARK: - Image Extension

extension RealmLocalRepository {

    func addImages(to breed: Breed, images: [BreedImage]) {
        do {
            let realm = try Realm()

            try realm.write {
                breed.images.append(objectsIn: images)
            }
        } catch let error as NSError {
            print("❌ RealmLocalRepository.addImages: Failed to add images : \(error)")
        }
    }

    func deleteImages(to breed: Breed) {
        do {
            let realm = try Realm()

            try realm.write {
                breed.images.removeAll()
            }
        } catch let error as NSError {
            print("❌ RealmLocalRepository.deleteImages: Failed to delete images : \(error)")
        }
    }

}

// MARK: - Filtering Extension

extension RealmLocalRepository {

    func filterBreeds(searchKey: String) {
        do {
            let realm = try Realm()
            let breeds = realm.objects(Breed.self)

            try realm.write {
                breeds.forEach { breed in
                    if searchKey.isEmpty {
                        breed.isFiltered = true
                    } else if let name = breed.name,
                              (name.range(of: searchKey, options: [.caseInsensitive, .diacriticInsensitive]) != nil) {
                        breed.isFiltered = true
                    } else {
                        breed.isFiltered = false
                    }
                }
            }
        } catch let error as NSError {
            print("❌ RealmLocalRepository.filterBreeds: Failed to update breeds: \(error)")
        }
    }

}
