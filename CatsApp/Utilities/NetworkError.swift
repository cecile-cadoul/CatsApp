//
//  NetworkError.swift
//  CatsApp
//
//  Created by Cecile on 08/09/2023.
//

import Foundation

// MARK: Network Error
enum NetworkError: Error {
    case custom(Error)
    case decoderError
    case httpCode(HTTPCode)
    case invalidURL
    case offlineError
    case unexpectedResponse
}

extension NetworkError: LocalizedError {

    var errorDescription: String? {
        switch self {
        case let .custom(error):
            return "\(error)"
        case .decoderError:
            return "Cannot decode from Data"
        case let .httpCode(code):
            return "Unexpected HTTP code: \(code)"
        case .invalidURL:
            return "Invalid URL"
        case .offlineError:
            return "The Internet connection appears to be offline."
        case .unexpectedResponse:
            return "Unexpected response"
        }
    }

}

// MARK: Domain Error
enum DomainError: Int {
    case notConnectedToInternet = -1009
}
