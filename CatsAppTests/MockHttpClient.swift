//
//  MockHttpClient.swift
//  CatsAppTests
//
//  Created by Cecile on 08/09/2023.
//

import Foundation
@testable import CatsApp

final class MockHttpClient: HttpClient, Mockable {

    var session: URLSession
    var scheme: String
    var baseUrl: String
    var sourceFileName: String

    init(session: URLSession = URLSession.shared,
         scheme: String = "http",
         baseUrl: String = "",
         sourceFileName: String) {
        self.session = session
        self.scheme = scheme
        self.baseUrl = baseUrl
        self.sourceFileName = sourceFileName
    }

    func fetchData<T: Codable>(endPoint: APICall,
                               parameters: [String: Any],
                               httpCodes: HTTPCodes
    ) async throws -> T {
        return loadJSON(fileName: sourceFileName, type: T.self)
    }

}
