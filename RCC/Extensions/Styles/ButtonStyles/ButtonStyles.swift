//
//  ButtonStyles.swift
//  RCC
//
//  Created by Aaron Huánuco on 24/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import UIKit

struct ButtonStyles {
    static let `default` = Style<UIButton> { _ in }
    
    static let main = Style<UIButton> {
        $0.titleLabel?.font = .medium16

        $0.setTitleColor(.rccBlue, for: .normal)
        $0.setTitleColor(UIColor.rccBlue.withAlphaComponent(0.5), for: .highlighted)
    }
}

extension UIButton {
    private static var _style = [String:Style<UIButton>]()
    
    var style: Style<UIButton> {
        get {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return UIButton._style[tmpAddress] ?? ButtonStyles.default
        } set {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            UIButton._style[tmpAddress] = newValue
            newValue.apply(to: self)
        }
    }
}
