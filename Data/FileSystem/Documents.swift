//
//  Documents.swift
//  Data
//
//  Created by Aaron Huánuco on 21/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import Foundation

extension Decodable {
    static func readJSONFrom<T:Decodable>(from file: String, fileExtension: String="json", bundle: Bundle) throws -> T {
        guard let url = bundle.url(forResource: file, withExtension: fileExtension) else {
            throw NSError(domain: NSURLErrorDomain, code: NSURLErrorResourceUnavailable)
        }
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
