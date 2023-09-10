//
//  ImageRemoteRepositoryTests.swift
//  CatsAppTests
//
//  Created by Cecile on 10/09/2023.
//

import XCTest
@testable import CatsApp

final class ImageRemoteRepositoryTests: XCTestCase {

    var remoteRepository: ImageRemoteRepository!

    override func setUp() {
        super.setUp()
        self.remoteRepository = ImageRemoteRepository(httpClient: MockHttpClient(sourceFileName: "ImagesResponse"))
    }

    override func tearDown() {
        super.tearDown()
        self.remoteRepository = nil
    }

    func testFetchImagesWithSuccess() async throws {
        let imagesResponse = try await self.remoteRepository.getImages(limitOfImage: 10,
                                                                       pageId: 0,
                                                                       breedIds: "beng",
                                                                       includeBreeds: false,
                                                                       imageSize: BreedImage.Size.med.rawValue)

        XCTAssertTrue(!imagesResponse.isEmpty)
    }

    @MainActor
    func testDecodeImageWithSuccess() async throws {
        let mockImage = BreedImage.mockedData
        let imagesResponse = try await self.remoteRepository.getImages(limitOfImage: 10,
                                                                       pageId: 0,
                                                                       breedIds: "beng",
                                                                       includeBreeds: false,
                                                                       imageSize: BreedImage.Size.med.rawValue)
        guard let image = imagesResponse.first else {
            XCTFail("❌ Failed to decode correctly")
            return
        }
        XCTAssertEqual(mockImage.id, image.id)
        XCTAssertEqual(mockImage.url, image.url)
        XCTAssertEqual(mockImage.width, image.width)
        XCTAssertEqual(mockImage.height, image.height)
    }

}
