//
//  DoubleFormattingTests.swift
//  Converter
//
//  Created by Aaron Huánuco on 18/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import Quick
import Nimble
@testable import Converter

final class DoubleFormattingTests: QuickSpec {
    override func spec() {
        describe("getting number formatted String from double") {
            it("should be have by default 4 decimal positions, positive number") {
                let sut = 2.0
                
                expect(sut.toString()).to(equal("2.0000"))
            }
            
            it("should be have by default 4 decimal positions, negative number") {
                let sut = -2.0
                
                expect(sut.toString()).to(equal("-2.0000"))
            }
            
            describe("rounding") {
                it("should limit the digits to the value provided if SUT has more") {
                    let sut = 0.12345
                    
                    expect(sut.toString()).to((equal("0.1235")))
                }
                
                it("should limit the digits to the value provided if SUT has more") {
                    let sut = 0.12344
                    
                    expect(sut.toString()).to((equal("0.1234")))
                }
            }
            
            it("should provide the stablished number of decimal digits") {
                
                let sut = 0.12344
                
                expect(sut.toString(decimalDigits: 7)).to((equal("0.1234400")))
            }
            
            it("should provide the stablished number of decimal digits") {
                
                let sut = 0.0001
                
                expect(sut.toString(decimalDigits: 7)).to((equal("0.0001000")))
            }
            
            it("should provide the stablished number of decimal digits") {
                
                let sut = 0.1
                
                expect(sut.toString(decimalDigits: 1)).to((equal("0.1")))
            }
        }
    }
}
