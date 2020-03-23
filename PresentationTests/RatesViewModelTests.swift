//
//  RatesViewModelTests.swift
//  Presentation
//
//  Created by Aaron Huánuco on 17/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import Quick
import Nimble
import Converter
@testable import Presentation

final class RatesViewModelTests: QuickSpec {
    override func spec() {
        var pairUseCase: PairInteractorProtocol!
        var exchangePairProvider: ExchangePairProvider!
        var sut: RatesViewModel!

        beforeEach {
            pairUseCase = MockingPairInteractor()
            exchangePairProvider = ExchangePairProviderMock()
            sut = RatesViewModel(pairUseCase: pairUseCase, exchangePairProvider: exchangePairProvider)
        }
    }
}

class MockingPairInteractor: PairInteractorProtocol {
    var fetchingStub: Result<[Pair], Error>!
    var savingStub: Result<Void, Error>!
    
    func getConfiguredPairs(completion: @escaping (Result<[Pair], Error>) -> Void) {
        completion(fetchingStub)
    }
    
    func save(_ pair: Pair, completion: @escaping (Result<Void, Error>) -> Void) {
        completion(savingStub)
    }
}

private final class ExchangePairProviderMock: ExchangePairProvider {
    func stopRetreavingPairs() {
        
    }
    
    func getExchangePairs(for pairs: [Pair], at interval: TimeInterval, completion: @escaping (Result<[ExchangePair], ExchangeProviderError>) -> Void) {
        
    }
}
