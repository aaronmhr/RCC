//
//  TimerProtocol.swift
//  Converter
//
//  Created by Aaron Huánuco on 17/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import Foundation

public protocol TimerProtocol {
    typealias CompletionBlock = () -> Void
    
    func fire()
    func invalidate()
    func schedule(timeInterval: TimeInterval, repeats: Bool, completionBlock: @escaping CompletionBlock)
}
