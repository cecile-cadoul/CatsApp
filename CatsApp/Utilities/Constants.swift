//
//  Constants.swift
//  CatsApp
//
//  Created by Cecile on 07/09/2023.
//

import Foundation

final class Constants {

    // MARK: API
    static let apiBaseUrl: String = Bundle.main.object(forInfoDictionaryKey: "ApiBaseUrl") as? String ?? ""
    static let apiKey: String = Bundle.main.object(forInfoDictionaryKey: "ApiKey") as? String ?? ""

    // MARK: Padding
    struct DefaultPadding {
        static let horizontal: CGFloat = 24
    }
}
