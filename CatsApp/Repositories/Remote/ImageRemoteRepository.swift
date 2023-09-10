//
//  ImageRemoteRepository.swift
//  CatsApp
//
//  Created by Cecile on 10/09/2023.
//

import Foundation

final class ImageRemoteRepository {

    var httpClient: HttpClient

    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }

    func getImages(limitOfImage: Int, pageId: Int, breedIds: String,
                   includeBreeds: Bool, imageSize: String) async throws -> [BreedImage] {
        let parameters: [String: Any] = ["limit": limitOfImage,
                          "page": pageId,
                          "breed_ids": breedIds,
                          "include_breeds": includeBreeds,
                          "size": imageSize,
                          "order": "DESC"]

        return try await httpClient.fetchData(endPoint: API.allImages, parameters: parameters, httpCodes: .success)
    }

}

// MARK: API
extension ImageRemoteRepository {

    enum API {
        case allImages
    }

}

extension ImageRemoteRepository.API: APICall {

    var path: String {
        switch self {
        case .allImages:
            return "/v1/images/search"
        }
    }

    var headers: [String: String]? {
        return [
            "Content-Type": "application/json",
            "x-api-key": Constants.apiKey
        ]
    }

}
