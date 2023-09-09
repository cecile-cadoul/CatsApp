//
//  HttpCodes.swift
//  CatsApp
//
//  Created by Cecile on 09/09/2023.
//

import Foundation

typealias HTTPCode = Int
typealias HTTPCodes = Range<HTTPCode>

extension HTTPCodes {
    static let success = 200 ..< 300
}
