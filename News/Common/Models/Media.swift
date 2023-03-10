//
//  Media.swift
//  News
//
//  Created by Philip on 08.03.2023.
//

import Foundation

struct Media: Codable {
    let mediaMetadata: [MediaMetadata]
    
    enum CodingKeys: String, CodingKey {
        case mediaMetadata = "media-metadata"
    }
}

struct MediaMetadata: Codable {
    let url: String
    let format: Format
}

enum Format: String, Codable {
    case standardThumbnail = "Standard Thumbnail"
    case mediumThreeByTwo20 = "mediumThreeByTwo210"
    case mediumThreeByTwo440 = "mediumThreeByTwo440"
}
