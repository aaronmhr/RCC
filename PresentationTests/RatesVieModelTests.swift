//
//  RatesVieModelTests.swift
//  Presentation
//
//  Created by Aaron Huánuco on 17/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import Quick
import Nimble
import Converter
@testable import Presentation

final class RatesVieModelTests: QuickSpec {
    override func spec() {
        var pairInteractor: PairInteractorProtocol!
        var sut: RatesVieModel!
        
        
        beforeEach {
            pairInteractor = MockingPairInteractor()
            sut = RatesVieModel(pairInteractor: pairInteractor)
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
