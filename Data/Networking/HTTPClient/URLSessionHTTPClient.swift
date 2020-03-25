//
//  URLSessionHTTPClient.swift
//  Data
//
//  Created by Aaron Huánuco on 15/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import Foundation

public final class URLSessionHTTPClient: HTTPClient {
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func get(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) {
        session.request(for: url, completion: completion)?.resume()
    }
}

private extension URLSession {
    func request(for url: URL, completion: @escaping (HTTPClient.Result) -> Void) -> URLSessionDataTask? {
        return dataTask(with: url) { (data, response, error) in
            switch (data, response, error) {
            case (let data?, .some(let httpResponse as HTTPURLResponse), nil):
                completion(.success((data, httpResponse)))
            case (nil, nil, let error?):
                completion(.failure(error))
            default:
                completion(.failure(Error.unexpected))
            }
        }
    }
    
    enum Error: Swift.Error {
        case unexpected
    }
}

// For simple GET requests we can consider that only 200 is OK
extension HTTPURLResponse {
    var isOK: Bool {
        return statusCode == 200
    }
}
