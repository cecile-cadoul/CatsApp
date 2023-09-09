//
//  HttpClient.swift
//  CatsApp
//
//  Created by Cecile on 08/09/2023.
//

import Foundation

protocol HttpClient {

    var session: URLSession { get }
    var scheme: String { get }
    var baseUrl: String { get }

    func fetchData<T: Codable>(endPoint: APICall, parameters: [String: Any], httpCodes: HTTPCodes) async throws -> T

}

final class URLSessionClient: HttpClient {

    var session: URLSession
    var scheme: String
    var baseUrl: String

    init(session: URLSession, scheme: String, baseUrl: String) {
        self.session = session
        self.scheme = scheme
        self.baseUrl = baseUrl
    }

    func fetchData<T: Codable>(endPoint: APICall,
                               parameters: [String: Any],
                               httpCodes: HTTPCodes = .success
    ) async throws -> T {
        guard let url = endPoint.urlComponents(scheme: self.scheme,
                                               host: self.baseUrl,
                                               parameters: parameters).url,
              let headers = endPoint.headers else {
            throw NetworkError.invalidURL
        }
        var request = URLRequest(url: url)

        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        print("Request: \(url)")
        let (data, response) = try await self.session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unexpectedResponse
        }
        print("Response status code: \(httpResponse.statusCode)")
        guard httpCodes.contains( httpResponse.statusCode) else {
            throw NetworkError.httpCode(httpResponse.statusCode)
        }
        guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else {
            throw NetworkError.decoderError
        }

        return decodedResponse
    }

}
