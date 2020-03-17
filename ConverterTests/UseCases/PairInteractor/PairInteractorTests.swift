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
        var repository: PairRepository!
        var sut: PairInteractor!
        
        beforeEach {
            repository = MockingPairRepository()
            sut = PairInteractor(repository: repository)
        }
        
        describe("asking for configured pairs") {
            
            context("no previous pair has been configured") {
                it("should return no `Pairs`") {
                    expect(sut.getConfiguredPairs()).to(beEmpty())
                }
            }
            
            describe("a `Pair` has been saved") {
                it("should return that `Pair`") {
                    let somePair = Pair.euro_pound
                    repository.savePair(somePair)
                    expect(sut.getConfiguredPairs()).to(equal([somePair]))
                }
            }
        }
    }
}

