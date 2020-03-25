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
        var sut: PairUseCase!
        
        beforeEach {
            repository = MockingPairRepository()
            sut = PairUseCase(repository: repository)
        }
        
        describe("asking for configured pairs") {
            
            context("if no previous pair has been configured") {
                it("should return no `Pairs`") {
                    
                   var obtainedResult: Result<[Pair], Error>?
                    sut.getConfiguredPairs { obtained in
                        obtainedResult = obtained
                    }
                    
                    expect(obtainedResult?.value).toEventually(beEmpty())
                }
            }
            
            describe("a `Pair` has been saved") {
                it("should return that `Pair`") {
                    let somePair = Pair.euro_pound
                    sut.save(somePair, completion: { _ in })
                    
                    var obtainedResult: Result<[Pair], Error>?
                    sut.getConfiguredPairs { obtained in
                        obtainedResult = obtained
                    }
                    
                    expect(obtainedResult?.value).to(equal([somePair]))
                }
            }
            
            describe("saving multiple pairs") {
                it("should return as many pairs as have been saved") {
                    let pairs = [ Pair.euro_pound, Pair.pound_dollar, Pair.dollar_euro]
                    pairs.forEach { sut.save($0, completion: { _ in })}
                    
                    var obtainedResult: Result<[Pair], Error>?
                     sut.getConfiguredPairs { obtained in
                         obtainedResult = obtained
                     }
                    
                    expect(obtainedResult?.value).to(equal(pairs.reversed()))
                }
            }
        }
    }
}
