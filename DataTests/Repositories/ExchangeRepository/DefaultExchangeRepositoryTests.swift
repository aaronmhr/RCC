//
//  DefaultExchangeRepositoryTests.swift
//  Data
//
//  Created by Aaron Huánuco on 16/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import Converter
import Quick
import Nimble
@testable import Data

final class DefaultExchangeRepositoryTests: QuickSpec {
    override func spec() {
        var sut: DefaultExchangeRepository!
        var dataSource: TestingUserDataSource!
        
        beforeEach {
            dataSource = TestingUserDataSource()
            sut = DefaultExchangeRepository(dataSource: dataSource)
        }
        
        describe("requesting exchange rates") {
            
            describe("if successful") {
                
                it("should recive an ExchangePair list") {
                    let expectedExchangePair = ExchangePair(pair: Pair.euro_dollar, rate: 1.0)
                    dataSource.stubResult = .success([expectedExchangePair])
                    
                    waitUntil(timeout: 5.0) { done in
                        sut.getExchangePairs(for: []) { result in
                            expect(result.value).to(equal([ExchangePair(pair: Pair.euro_dollar, rate: 1.0)]))
                            done()
                        }
                    }
                }
            }
            
            describe("on failure") {
                it("should not receive a success value") {
                    dataSource.stubResult = .failure(.connectivity)
                    
                    waitUntil(timeout: 1.0) { done in
                        sut.getExchangePairs(for: []) { result in
                            expect(result.value).to(beNil())
                            done()
                        }
                    }
                }
                
                it("should receive a repository error from a connectivity issue") {
                    dataSource.stubResult = .failure(.connectivity)
                    
                    waitUntil(timeout: 1.0) { done in
                        sut.getExchangePairs(for: []) { result in
                            expect(result.error).to(equal(.remote))
                            done()
                        }
                    }
                }

                it("should receive a repository error from a invalid data issue") {
                    dataSource.stubResult = .failure(.invalidData)
                    
                    waitUntil(timeout: 1.0) { done in
                        sut.getExchangePairs(for: []) { result in
                            expect(result.error).to(equal(.remote))
                            done()
                        }
                    }
                }
                
                it("should receive a repository error from a invalid url issue") {
                    dataSource.stubResult = .failure(.invalidURL)
                    
                    waitUntil(timeout: 1.0) { done in
                        sut.getExchangePairs(for: []) { result in
                            expect(result.error).to(equal(.remote))
                            done()
                        }
                    }
                }
                
                it("should receive a repository error from a invalid other issue") {
                    dataSource.stubResult = .failure(.other)
                    
                    waitUntil(timeout: 1.0) { done in
                        sut.getExchangePairs(for: []) { result in
                            expect(result.error).to(equal(.remote))
                            done()
                        }
                    }
                }
            }
        }
    }
}
