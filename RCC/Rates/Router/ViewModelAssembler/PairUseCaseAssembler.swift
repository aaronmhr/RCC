//
//  PairUseCaseAssembler.swift
//  RCC
//
//  Created by Aaron Huánuco on 22/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import Converter
import CoreData
import Data

final class PairUseCaseAssembler {
    private static let datasource: PairDataSource = {
        try! CoreDataLocalStore(storeURL: NSPersistentContainer.defaultDirectoryURL().appendingPathComponent("local-store.sqlite"))
    }()

    private static let repository: DefaultPairRepository = {
        DefaultPairRepository(datasource: PairUseCaseAssembler.datasource, currentDate: Date.init)
    }()
    
    static func assemble() -> PairInteractorProtocol {
        return  PairUseCase(repository: PairUseCaseAssembler.repository)
    }
}
