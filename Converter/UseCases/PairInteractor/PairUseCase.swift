//
//  PairUseCase.swift
//  Converter
//
//  Created by Aaron Huánuco on 17/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

public typealias PairInteractorProtocol = PairProvider & PairSaver

public final class PairUseCase {
    private let repository: PairRepository
    
    public init(repository: PairRepository) {
        self.repository = repository
    }
}

extension PairUseCase: PairProvider {
    public func getConfiguredPairs() -> [Pair] {
        return repository.getPairs()
    }
}

extension PairUseCase: PairSaver {
    public func save(_ pair: Pair) {
        guard !getConfiguredPairs().contains(pair) else { return }
        repository.savePair(pair)
    }
}

public protocol PairRepository {
    func getPairs() -> [Pair]
    func savePair(_ pair: Pair)
}

public class MockingPairRepository: PairRepository {
    
    public init() { }
    
    private var pairsStack: [Pair] = [Pair(with: Currency.Builder.build(from: "USD")!, and: Currency.Builder.build(from: "EUR")!)]
    
    public func getPairs() -> [Pair] {
        return pairsStack
    }
    
    public func savePair(_ pair: Pair) {
        pairsStack.append(pair)
    }
}
