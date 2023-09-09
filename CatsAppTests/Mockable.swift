//
//  Mockable.swift
//  CatsAppTests
//
//  Created by Cecile on 08/09/2023.
//

import Foundation

protocol Mockable: AnyObject {

    var bundle: Bundle { get }
    func loadJSON<T: Decodable>(fileName: String, type: T.Type) -> T

}

extension Mockable {

    var bundle: Bundle {
        return Bundle(for: type(of: self))
    }

    func loadJSON<T: Decodable>(fileName: String, type: T.Type) -> T {
        guard let path = bundle.url(forResource: fileName, withExtension: "json") else {
            print("❌ Failed to load JSON file.")
            fatalError("Failed to load JSON file.")
        }

        do {
            let data = try Data(contentsOf: path)
            let decodedData = try JSONDecoder().decode(T.self, from: data)

            return decodedData
        } catch {
            print("❌ Failed to decode the JSON: \(error).")
            fatalError("Failed to decode the JSON")
        }
    }

}
