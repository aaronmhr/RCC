//
//  Converter + CoreData.swift
//  Data
//
//  Created by Aaron Huánuco on 23/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import Converter

extension Pair {
    var coreDataID: String {
        return first.code + second.code
    }
}
