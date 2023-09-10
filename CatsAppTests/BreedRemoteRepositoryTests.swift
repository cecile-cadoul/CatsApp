//
//  BreedRemoteRepositoryTests.swift
//  CatsAppTests
//
//  Created by Cecile on 07/09/2023.
//

import XCTest
@testable import CatsApp

final class BreedRemoteRepositoryTests: XCTestCase {

    var remoteRepository: BreedRemoteRepository!

    override func setUp() {
        super.setUp()
        self.remoteRepository = BreedRemoteRepository(httpClient: MockHttpClient(sourceFileName: "BreedsResponse"))
    }

    override func tearDown() {
        super.tearDown()
        self.remoteRepository = nil
    }

    func testFetchBreedsWithSuccess() async throws {
        let breedsResponse = try await self.remoteRepository.getBreeds(limitOfBreed: 3, pageId: 0)

        XCTAssertTrue(!breedsResponse.isEmpty)
    }

    @MainActor
    func testDecodeBreedWithSuccess() async throws {
        let mockBreed = Breed.mockedData
        let breedsResponse = try await self.remoteRepository.getBreeds(limitOfBreed: 3, pageId: 0)

        guard let dataBreed = breedsResponse.first else {
            XCTFail("❌ Failed to decode correctly")
            return
        }
        XCTAssertEqual(mockBreed.id, dataBreed.id)
        XCTAssertEqual(mockBreed.name, dataBreed.name)
        XCTAssertEqual(mockBreed.breedDescription, dataBreed.breedDescription)
        XCTAssertEqual(mockBreed.indoor, dataBreed.indoor)
        XCTAssertEqual(mockBreed.referenceImageId, dataBreed.referenceImageId)
    }

}
