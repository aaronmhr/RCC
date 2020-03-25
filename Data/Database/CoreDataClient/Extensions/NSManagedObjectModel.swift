//
//  NSManagedObjectModel.swift
//  Data
//
//  Created by Aaron Huánuco on 23/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import CoreData

extension NSManagedObjectModel {
    static func with(name: String, in bundle: Bundle) -> NSManagedObjectModel? {
        return bundle
            .url(forResource: name, withExtension: "momd")
            .flatMap { NSManagedObjectModel(contentsOf: $0) }
    }
}
