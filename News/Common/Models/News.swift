//
//  News.swift
//  News
//
//  Created by Philip on 07.03.2023.
//

import Foundation

struct News: Codable {
    var results: [Results]
    
}

struct Results: Codable {
    let title: String
    let url: String
    let publishedDate: String
    let section: String
    let abstract: String
    let media: [Media]
    
    enum CodingKeys: String, CodingKey {
        case title, url, section, abstract, media
        case publishedDate = "published_date"
    }
}

