//
//  Video.swift
//  VideoPlayerSwiftUI
//
//  Created by Amin  Bagheri  on 2022-08-24.
//

// MARK:  The returned JSON will be parsed in this object.

import Foundation

// MARK: - VideoElement
struct VideoElement: Codable {
    let id, title: String
    let hlsURL: String
    let fullURL: String
    let videoDescription, publishedAt: String
    let author: Author
    var date: Date? {
        print("PUBLISHED AT", publishedAt)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: publishedAt) // replace Date String
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title, hlsURL, fullURL
        case videoDescription = "description"
        case publishedAt, author
    }
}

// MARK: - Author
struct Author: Codable {
    let id, name: String
}

typealias Video = [VideoElement]
