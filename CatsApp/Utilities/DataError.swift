//
//  DataError.swift
//  CatsApp
//
//  Created by Cecile on 09/09/2023.
//

import Foundation

enum DataError: Error {
    case emptyData
}

extension DataError: LocalizedError {

    var errorDescription: String? {
        switch self {
        case .emptyData:
            return "No more data available"
        }
    }

}
