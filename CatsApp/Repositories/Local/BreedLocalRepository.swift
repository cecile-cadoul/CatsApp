//
//  BreedLocalRepository.swift
//  CatsApp
//
//  Created by Cecile on 07/09/2023.
//

import Foundation
import RealmSwift

final class RealmLocalRepository: LocalRepository {

    func saveData<T>(data: [T]) {
        do {
            let realm = try Realm()

            guard let dataObject = data as? [Object] else {
                print("❌ Realm error: data does not comform to Object type: \(data)")
                return
            }
            try realm.write {
                realm.add(dataObject, update: .modified)
            }
        } catch let error as NSError {
            print("❌ Realm error: Failed to save breeds: \(error)")
        }
    }

    func deleteData<T>(data: [T]) {
        do {
            let realm = try Realm()

            guard let dataObject = data as? [Object] else {
                print("❌ Realm: data does not comform to Object type: \(data)")
                return
            }
            try realm.write {
                realm.delete(dataObject)
            }
        } catch let error as NSError {
            print("❌ Realm: Failed to delete breeds: \(error)")
        }
    }

}
