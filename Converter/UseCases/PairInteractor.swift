//
//  PairInteractor.swift
//  Converter
//
//  Created by Aaron Huánuco on 17/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//


final class PairInteractor {
    private let repository: PairRepository
    
    init(repository: PairRepository) {
        self.repository = repository
    }
}

extension PairInteractor: PairProvider {
    func getConfiguredPairs() -> [Pair] {
        return repository.getPairs()
    }
}

extension PairInteractor: PairSaver {
    func save(_ pair: Pair) {
        guard !getConfiguredPairs().contains(pair) else { return }
        repository.savePair(pair)
    }
}





public protocol PairRepository {
    func getPairs() -> [Pair]
    func savePair(_ pair: Pair)
}

public class MockingPairRepository: PairRepository {
    private var pairsStack: [Pair] = []
    
    public func getPairs() -> [Pair] {
        return pairsStack
    }
    
    public func savePair(_ pair: Pair) {
        pairsStack.append(pair)
    }
}
