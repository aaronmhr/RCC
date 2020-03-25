//
//  DefaultTimerTests.swift
//  Converter
//
//  Created by Aaron Huánuco on 17/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import Quick
import Nimble
@testable import Converter

final class DefaultTimerTests: QuickSpec {
    override func spec() {
        var sut: DefaultTimer!
        
        beforeEach {
            sut = DefaultTimer()
        }
        
        describe("on init SUT") {
            it("internal timer should be nil") {
                expect(sut.timer).to(beNil())
            }
            
            it("internal timer should be nil if fired without configuring") {
                sut.fire()
                
                expect(sut.timer).to(beNil())
            }
        }
        
        describe("scheduling") {
            it("should cerate a timer") {
                sut.schedule(timeInterval: 0.1, repeats: false) { }
                expect(sut.timer).toNot(beNil())
            }
            
            it("should repeate the closure at the required interval") {
                var counter = 0
                sut.schedule(timeInterval: 0.01, repeats: true) {
                    counter += 1
                }
                expect(counter).toEventually(beGreaterThan(1))
            }
        }
    }
}
