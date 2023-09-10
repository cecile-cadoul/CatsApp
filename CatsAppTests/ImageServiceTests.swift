//
//  ImageServiceTests.swift
//  CatsAppTests
//
//  Created by Cecile on 10/09/2023.
//

import XCTest
@testable import CatsApp

final class ImageServiceTests: XCTestCase {

    var service: ImageService!

    override func setUp() {
        super.setUp()
        let remoteRepository = ImageRemoteRepository(httpClient: MockHttpClient(sourceFileName: "EmptyResponse"))
        let localRepository = MockLocalRepository()

        self.service = ImageService(remoteRepository: remoteRepository, localRepository: localRepository)
    }

    override func tearDown() {
        super.tearDown()
        self.service = nil
    }

    func testFetchEmptyImagesWithSuccess() async {
        let remoteRepository = ImageRemoteRepository(httpClient: MockHttpClient(sourceFileName: "EmptyResponse"))
        let localRepository = MockLocalRepository()

        self.service = ImageService(remoteRepository: remoteRepository, localRepository: localRepository)

        var emptyDataError: Error?

        do {
            try await service.fetchBreedImages(breed: Breed.mockedData,
                                               limitOfImage: 10,
                                               pageId: 0,
                                               includeBreeds: false,
                                               imageSize: BreedImage.Size.small.rawValue)
        } catch {
            emptyDataError = error
        }

        XCTAssertEqual(emptyDataError as? DataError, DataError.emptyData)
    }

}
