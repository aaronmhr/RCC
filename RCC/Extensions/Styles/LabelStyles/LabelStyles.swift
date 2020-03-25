
//
//  LabelStyles.swift
//  RCC
//
//  Created by Aaron Huánuco on 24/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import UIKit

struct LabelStyles {
    static let `default` = Style<UILabel> { _ in }
    
    static let regular16Black = Style<UILabel> {
        $0.textColor = .rccBlack
        $0.font = .regular16
    }
    
    static let medium16Black = Style<UILabel> {
        $0.textColor = .rccBlack
        $0.font = .medium16
    }
    
    static let medium20Black = Style<UILabel> {
        $0.textColor = .rccBlack
        $0.font = .medium20
    }
}

extension LabelStyles {
    static let regular14Gray = Style<UILabel> {
        $0.textColor = .rccGray
        $0.font = .regular14
    }
    
    static let regular16Gray = Style<UILabel> {
        $0.textColor = .rccGray
        $0.font = .regular16
    }
}

extension LabelStyles {
    static let medium16Blue = Style<UILabel> {
        $0.textColor = .rccBlue
        $0.font = .medium16
    }
}

extension UILabel {
    private static var _style = [String:Style<UILabel>]()
    
    var style: Style<UILabel> {
        get {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return UILabel._style[tmpAddress] ?? LabelStyles.default
        } set {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            UILabel._style[tmpAddress] = newValue
            newValue.apply(to: self)
        }
    }
}
