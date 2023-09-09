//
//  BreedLocalRepositoryTests.swift
//  CatsAppTests
//
//  Created by Cecile on 08/09/2023.
//

import XCTest
import RealmSwift
@testable import CatsApp

final class BreedLocalRepositoryTests: XCTestCase {

    var localRepository: LocalRepository!

    override func setUp() {
        super.setUp()
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
        self.localRepository = RealmLocalRepository()
    }

    override func tearDown() {
        super.tearDown()
        self.localRepository = nil
    }

    func testSaveBreedWithSuccess() throws {
        let breeds = Breed.mockedData

        guard let breed = breeds.first else {
            XCTFail("Reference data is missing.")
            return
        }

        self.localRepository.saveData(data: breeds)

        do {
            let realm = try Realm()
            guard let savedBreed = realm.object(ofType: Breed.self, forPrimaryKey: breed.id) else {
                XCTFail("Failed to save data.")
                return
            }

            XCTAssertEqual(breed.id, savedBreed.id)
            XCTAssertEqual(breed.name, savedBreed.name)
            XCTAssertEqual(breed.adaptability, savedBreed.adaptability)
            XCTAssertEqual(breed.name, savedBreed.name)
        } catch {
            XCTFail("Failed to open a Realm instance.")
        }
    }

}
