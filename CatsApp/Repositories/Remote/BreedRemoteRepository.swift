//
//  BreedRemoteRepository.swift
//  CatsApp
//
//  Created by Cecile on 07/09/2023.
//

import Foundation

final class BreedRemoteRepository: RemoteRepository {

    var httpClient: HttpClient

    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }

    func fetchData<T: Codable>(type: T.Type, parameters: [String: Any]) async throws -> T {
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
