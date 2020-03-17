//
//  TimerMock.swift
//  ConverterTests
//
//  Created by Aaron Huánuco on 17/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import Converter

final class TimerMock: TimerProtocol {
    var timeInterval: TimeInterval?
    
    func fire() { }
    func invalidate() {}
    
    func schedule(timeInterval: TimeInterval, repeats: Bool, completionBlock: @escaping TimerProtocol.CompletionBlock) {
        self.timeInterval = timeInterval
        completionBlock()
    }
}
