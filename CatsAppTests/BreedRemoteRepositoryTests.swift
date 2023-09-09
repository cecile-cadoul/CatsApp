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
        let mockBreeds = Breed.mockedData
        let breedsResponse = try await self.remoteRepository.getBreeds(limitOfBreed: 3, pageId: 0)

        guard let refBreed = mockBreeds.first, let dataBreed = breedsResponse.first else {
            XCTFail("❌ Failed to decode correctly")
            return
        }
        XCTAssertEqual(refBreed.id, dataBreed.id)
        XCTAssertEqual(refBreed.name, dataBreed.name)
        XCTAssertEqual(refBreed.breedDescription, dataBreed.breedDescription)
        XCTAssertEqual(refBreed.indoor, dataBreed.indoor)
        XCTAssertEqual(refBreed.referenceImageId, dataBreed.referenceImageId)
    }

}
