//
//  VideoCallerError.swift
//  VideoPlayerSwiftUI
//
//  Created by Amin  Bagheri  on 2022-08-24.
//

import Foundation

enum VideoCallerError: Error {
    case failedToConvertURL
    case apiReturnedNoData
}

extension VideoCallerError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .failedToConvertURL:
            return NSLocalizedString("Error converting urlString to URL", comment: "URL Error 1")
        case .apiReturnedNoData:
            return NSLocalizedString("No data returned from API", comment: "Data Error 1")
        }
        
    }
}
