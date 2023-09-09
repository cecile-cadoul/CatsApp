//
//  BreedRemoteRepository.swift
//  CatsApp
//
//  Created by Cecile on 07/09/2023.
//

import Foundation

final class BreedRemoteRepository {

    var httpClient: HttpClient

    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }

    func getBreeds(limitOfBreed: Int, pageId: Int) async throws -> [Breed] {
        let parameters = ["limit": limitOfBreed,
                          "page": pageId]

        return try await httpClient.fetchData(endPoint: API.allBreeds, parameters: parameters, httpCodes: .success)
    }

}

// MARK: API
extension BreedRemoteRepository {

    enum API {
        case allBreeds
    }

}

extension BreedRemoteRepository.API: APICall {

    var path: String {
        switch self {
        case .allBreeds:
            return "/v1/breeds"
        }
    }

    var headers: [String: String]? {
        return [
            "Content-Type": "application/json",
            "x-api-key": Constants.apiKey
        ]
    }

}
