//
//  Endpoint.swift
//  News
//
//  Created by Philip on 08.03.2023.
//

import Foundation

enum Endpoint {
    case emailed
    case viewed
    case shared
    
    var url: URL {
        switch self {
        case .viewed:
            return .makeForEndpoint(endpoint: .viewed)
        case .emailed:
            return .makeForEndpoint(endpoint: .emailed)
        case .shared:
            return .makeForEndpoint(endpoint: .shared)
        }
    }
}

private extension URL {
    static func makeForEndpoint(endpoint: Endpoint) -> URL {
        guard let url = URL(string: "\(APIConstants.baseURL)\(endpoint)/1.json?api-key=\(APIConstants.key)") else {
            preconditionFailure("Invald URL")
        }
        return url
    }
}
