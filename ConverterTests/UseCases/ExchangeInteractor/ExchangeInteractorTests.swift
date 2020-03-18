//
//  ExchangeInteractorTests.swift
//  Converter
//
//  Created by Aaron Huánuco on 17/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import Quick
import Nimble
@testable import Converter

final class ExchangeInteractorTests: QuickSpec {
    override func spec() {
        var repository: ExchangeRepositoryMock!
        var timer: TimerMock!
        var sut: ExchangeUseCase!
        
        beforeEach {
            repository = ExchangeRepositoryMock()
            timer = TimerMock()
            sut = ExchangeUseCase(repository: repository, timer: timer)
        }
        
        describe("on getting ExchangePairs") {
            it("should forward timeinterval input to timer on error") {
                let intervalInput = 1.0
                repository.stub(.failure(.remote))
                
                sut.getExchangePairs(for: [], at: intervalInput) { _ in
                    expect(timer.timeInterval).to(equal(intervalInput))
                }
            }
            
            it("should forward timeinterval input to timer on success") {
                let intervalInput = 2.0
                repository.stub(.success([]))
                
                sut.getExchangePairs(for: [], at: intervalInput) { _ in
                    expect(timer.timeInterval).to(equal(intervalInput))
                }
            }
            
            it("should forward pairs input to repository") {
                let pair = [Pair.euro_pound]
                repository.stub(.success([]))
                
                sut.getExchangePairs(for: pair, at: 1.0) { _ in
                    expect(repository.receivedPairs).to(equal(pair))
                }
            }
        }
        
        describe("getting ExchangePairs fails") {
            it("should complete with an error") {
                let failResult: ExchangeRepository.Result = .failure(.remote)
                repository.stub(failResult)
                
                sut.getExchangePairs(for: [], at: 1.0) { result in
                    expect(result.error).to(equal(.remote))
                }
            }
        }
        
        describe("getting ExchagePairs succeds") {
            it("should complete with success") {
                let expectedPairs = [ExchangePair.euro_dolarOne, ExchangePair.euro_dolarTwo]
                let success: ExchangeRepository.Result = .success(expectedPairs)
                repository.stub(success)
                
                sut.getExchangePairs(for: [], at: 1.0) { result in
                    expect(result.value).to(equal(expectedPairs))
                }
            }
        }
    }
}
