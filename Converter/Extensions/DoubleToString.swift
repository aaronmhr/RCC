//
//  DoubleToString.swift
//  Converter
//
//  Created by Aaron Huánuco on 18/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import Foundation

extension Double {
    public func toString(decimalDigits: Int = 4) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = decimalDigits
        numberFormatter.minimumFractionDigits = decimalDigits
        numberFormatter.roundingMode = .halfUp
        let digitString = numberFormatter.string(from: NSNumber(value: self))
        return digitString
    }
}
