//
//  HTTPClientSpy.swift
//  DataTests
//
//  Created by Aaron Huánuco on 15/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import Data

class HTTPClientSpy: HTTPClient {
    private var message: (url: URL, completion: (HTTPClient.Result) -> Void)?
    
    var requestedURL: URL? {
        return message?.url
    }
    
    func get(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) {
        message = (url, completion)
    }
    
    func complete(with error: Error) {
        message?.completion(.failure(error))
    }
    
    func complete(withStatusCode code: Int, data: Data) {
        let response = HTTPURLResponse(
            url: requestedURL!,
            statusCode: code,
            httpVersion: nil,
            headerFields: nil
        )!
        message?.completion(.success((data, response)))
    }
}
