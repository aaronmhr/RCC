//
//  Result.swift
//  Converter
//
//  Created by Aaron Huánuco on 16/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import Foundation

public extension Result {
    var value: Success? {
        guard case let Result.success(value) = self else { return nil }
        return value
    }

    var error: Failure? {
        guard case let Result.failure(error) = self else { return nil }
        return error
    }
}
