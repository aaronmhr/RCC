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
                    sut.save(somePair)
                    
                    expect(sut.getConfiguredPairs()).to(equal([somePair]))
                }
            }
            
            describe("saving multiple pairs") {
                it("should return as many pairs as have been saved") {
                    let pairs = [ Pair.euro_pound, Pair.pound_dollar, Pair.dollar_euro]
                    pairs.forEach(sut.save(_:))
                    
                    expect(sut.getConfiguredPairs()).to(equal(pairs))
                }
            }
            
            describe("saving multiple pairs with repeated ones") {
                it("should return only non repeated pairs") {
                    let uniquePair = Pair.dollar_euro
                    let pairs = [uniquePair, uniquePair]
                    pairs.forEach(sut.save(_:))
                    
                    expect(sut.getConfiguredPairs()).to(equal([uniquePair]))
                }
            }
        }
    }
}

