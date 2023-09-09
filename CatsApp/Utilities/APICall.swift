//
//  APICall.swift
//  CatsApp
//
//  Created by Cecile on 07/09/2023.
//

import Foundation

protocol APICall {

    var path: String { get }
    var headers: [String: String]? { get }

}

extension APICall {

    func urlComponents(scheme: String, host: String, parameters: [String: Any]) -> URLComponents {
        var components = URLComponents()

        components.scheme = scheme
        components.host = host
        components.path = path
        components.setQueryItems(with: parameters)

        return components
    }

}

public extension URLComponents {

    mutating func setQueryItems(with parameters: [String: Any]) {
        self.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: "\(value)")
        }
    }

}
