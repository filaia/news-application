//
//  Results.swift
//  News
//
//  Created by Philip on 07.03.2023.
//

import Foundation

struct News: Codable {
    var results: [Results]
}

struct Results: Codable {
    let url: String
    let published_date: String
    let title: String
}

