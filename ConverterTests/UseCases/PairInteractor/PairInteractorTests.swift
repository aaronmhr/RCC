//
//  PairInteractorTests.swift
//  Converter
//
//  Created by Aaron Huánuco on 17/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import Quick
import Nimble
@testable import Converter

final class PairInteractorTests: QuickSpec {
    override func spec() {
        var sut: PairInteractor!
        
        beforeEach {
            let repository = MockingPairRepository()
            sut = PairInteractor(repository: repository)
        }
        
        describe("asking for configured pairs") {
            
            context("no previous pair has been configured") {
                it("should return no `Pairs`") {
                    expect(sut.getConfiguredPairs()).to(beEmpty())
                }
            }
        }
    }
}

