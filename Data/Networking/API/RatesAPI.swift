//
//  RatesAPI.swift
//  Data
//
//  Created by Aaron Huánuco on 15/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import Foundation

enum RatesAPI {
    case pairs([String])
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.baseURL
        components.path = Constants.path
        components.queryItems = queryItems
        return components.url
    }
    
    private var queryItems: [URLQueryItem]? {
        switch self {
        case .pairs(let pairs):
            return pairs.map(queryForPair(_:))
        }
    }
    
    private func queryForPair(_ pair: String) -> URLQueryItem {
        return URLQueryItem(name: Constants.pairQuery, value: pair)
    }
}

extension RatesAPI {
    private enum Constants {
        static let scheme = "https"
        static let baseURL = "europe-west1-revolut-230009.cloudfunctions.net"
        static let path = "/revolut-ios"
        static let pairQuery = "pairs"
    }
}
