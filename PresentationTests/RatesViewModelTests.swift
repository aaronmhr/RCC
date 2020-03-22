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
    var pairStub: [Pair] = []
    func getConfiguredPairs() -> [Pair] {
        return pairStub
    }
    
    func save(_ pair: Pair) {
        pairStub.append(pair)
    }
}

private final class ExchangePairProviderMock: ExchangePairProvider {
    func stopRetreavingPairs() {
        
    }
    
    func getExchangePairs(for pairs: [Pair], at interval: TimeInterval, completion: @escaping (Result<[ExchangePair], ExchangeProviderError>) -> Void) {
        
    }
}
