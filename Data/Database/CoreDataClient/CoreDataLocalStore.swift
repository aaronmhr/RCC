//
//  CoreDataLocalStore.swift
//  Data
//
//  Created by Aaron Huánuco on 22/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import CoreData
import Converter

public final class CoreDataLocalStore {
    private static let modelName = "LocalStore"
    private static let model = NSManagedObjectModel.with(name: modelName, in: Bundle(for: CoreDataLocalStore.self))
    
    private let container: NSPersistentContainer
    private let context: NSManagedObjectContext
    
    public init(storeURL: URL) throws {
        guard let model = CoreDataLocalStore.model else {
            throw StoreError.modelNotFound
        }
        
        do {
            container = try NSPersistentContainer.load(name: CoreDataLocalStore.modelName, model: model, url: storeURL)
            context = container.newBackgroundContext()
        } catch {
            throw StoreError.failedToLoadPersistentContainer(error)
        }
    }
    
    func perform(_ action: @escaping (NSManagedObjectContext) -> Void) {
        let context = self.context
        context.perform { action(context) }
    }
    
    private func cleanUpReferencesToPersistentStores() {
        context.performAndWait {
            let coordinator = self.container.persistentStoreCoordinator
            try? coordinator.persistentStores.forEach(coordinator.remove)
        }
    }
    
    enum StoreError: Error {
        case modelNotFound
        case failedToLoadPersistentContainer(Error)
    }
    
    deinit {
        cleanUpReferencesToPersistentStores()
    }
}

extension CoreDataLocalStore: PairDataSource {
    public func delete(_ pair: Pair, completion: @escaping DeletionCompletion) {
        perform { context in
            completion(Result {
                try CoreDataPair.find(pair, in: context).map(context.delete).map(context.save)
            })
        }
    }
    
    public func insert(_ pair: Pair, timestamp: Date, completion: @escaping InsertionCompletion) {
        perform { context in
            completion(Result {
                let coreDataPair = try CoreDataPair.newUniqueInstance(of: pair, in: context)
                coreDataPair.id = pair.coreDataID
                coreDataPair.firstCurrencyCode = pair.first.code
                coreDataPair.secondCurrencyCode = pair.second.code
                coreDataPair.date = timestamp
                try context.save()
            })
        }
    }
    
    public func retrieve(completion: @escaping RetrievalCompletion) {
        perform { context in
            completion(Result {
                try CoreDataPair.get(in: context).compactMap(CoreDataPair.makePair(from:))
            })
        }
    }
}
