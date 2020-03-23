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
    public func getConfiguredPairs(completion: @escaping (Result<[Pair], Error>) -> Void) {
        repository.fetch(completion: completion)
    }
}

extension PairUseCase: PairSaver {
    public func save(_ pair: Pair, completion: @escaping (Result<Void, Error>) -> Void) {
        repository.save(pair, completion: completion)
    }
}

public protocol PairRepository {
    typealias SaveResult = Swift.Result<Void, Error>
    typealias FetchResult = Swift.Result<[Pair], Error>

    func save(_ pair: Pair, completion: @escaping (SaveResult) -> Void)
    func fetch(completion: @escaping (FetchResult) -> Void)
}
