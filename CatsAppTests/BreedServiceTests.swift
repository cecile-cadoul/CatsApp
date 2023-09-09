//
//  BreedServiceTests.swift
//  CatsAppTests
//
//  Created by Cecile on 09/09/2023.
//

import XCTest
@testable import CatsApp

final class BreedServiceTests: XCTestCase {

    var service: BreedService!

    override func setUp() {
        super.setUp()
        let remoteRepository = BreedRemoteRepository(httpClient: MockHttpClient(sourceFileName: "EmptyResponse"))
        let localRepository = MockLocalRepository()

        self.service = BreedService(remoteRepository: remoteRepository, localRepository: localRepository)
    }

    override func tearDown() {
        super.tearDown()
        self.service = nil
    }

    func testFetchEmptyBreedsWithSuccess() async {
        var emptyDataError: Error?

        do {
            try await service.fetchBreeds(limitOfBreed: 10, pageId: 0)
        } catch {
            emptyDataError = error
        }

        XCTAssertEqual(emptyDataError as? DataError, DataError.emptyData)
    }

}
