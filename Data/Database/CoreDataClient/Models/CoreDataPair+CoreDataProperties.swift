//
//  CoreDataPair.swift
//  Data
//
//  Created by Aaron Huánuco on 22/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import CoreData
import Converter

extension CoreDataPair {
    @NSManaged var id: String
    @NSManaged var firstCurrencyCode: String
    @NSManaged var secondCurrencyCode: String
    @NSManaged var date: Date
}

extension CoreDataPair {
    static func find(_ pair: Pair, in context: NSManagedObjectContext) throws -> CoreDataPair? {
        let request = NSFetchRequest<CoreDataPair>(entityName: String(describing: CoreDataPair.self))
        request.predicate = NSPredicate(format: "id = %@", pair.coreDataID)
        return try context.fetch(request).first
    }
    
    static func get(in context: NSManagedObjectContext) throws -> [CoreDataPair] {
        let request = NSFetchRequest<CoreDataPair>(entityName: String(describing: CoreDataPair.self))
        request.returnsObjectsAsFaults = false
        return try context.fetch(request)
    }
    
    static func newUniqueInstance(of pair: Pair, in context: NSManagedObjectContext) throws -> CoreDataPair {
        try find(pair, in: context).map(context.delete)
        return CoreDataPair(context: context)
    }
    
    static func delete(_ pair: Pair) -> Result<Void, Error> {
        let request = NSFetchRequest<CoreDataPair>(entityName: "CoreDataPair")
        request.predicate = NSPredicate(format: "id = %@", pair.coreDataID)
        return .success(())
    }
}

extension CoreDataPair {
    static func makePair(from model: CoreDataPair) -> Pair? {
        guard let firstCurreny = Currency.Builder.build(from: model.firstCurrencyCode),
            let secondCurreny = Currency.Builder.build(from: model.secondCurrencyCode) else { return nil }
        return Pair(with: firstCurreny, and: secondCurreny)
    }
}
