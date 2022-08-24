//
//  VideoCallerError.swift
//  VideoPlayerSwiftUI
//
//  Created by Amin  Bagheri  on 2022-08-24.
//

import Foundation

// Custom errors for our API Caller
enum VideoCallerError: Error {
    case failedToConvertURL
    case apiReturnedNoData
    case incorrectStatusCode
}

// Localized descriptions we can use to print and debug
extension VideoCallerError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .failedToConvertURL:
            return NSLocalizedString("Error converting urlString to URL", comment: "URL Error 1")
        case .apiReturnedNoData:
            return NSLocalizedString("No data returned from API", comment: "Data Error 1")
        case .incorrectStatusCode:
            return NSLocalizedString("Incorrect status code", comment: "Status code Error 1")
        }
        
    }
}
