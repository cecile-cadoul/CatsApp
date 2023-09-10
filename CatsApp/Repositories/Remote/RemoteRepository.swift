//
//  RemoteRepository.swift
//  CatsApp
//
//  Created by Cecile on 10/09/2023.
//

import Foundation

protocol RemoteRepository {

    var httpClient: HttpClient { get }

    func fetchData<T: Codable>(type: T.Type, parameters: [String: Any]) async throws -> T

}
