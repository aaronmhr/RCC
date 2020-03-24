//
//  NavigationBarStyles.swift
//  RCC
//
//  Created by Aaron Huánuco on 24/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import UIKit

struct NavigationBarStyles {
    static let `default` = Style<UINavigationBar> { _ in }
    
    static let main = Style<UINavigationBar> {
        $0.titleTextAttributes = [.foregroundColor: UIColor.rccBlack, .font: UIFont.regular16]
    }
    
    static let white = Style<UINavigationBar> {
        $0.titleTextAttributes = [.foregroundColor: UIColor.rccWhite, .font: UIFont.regular16]
    }
}

extension UINavigationBar {
    private static var _style = [String:Style<UINavigationBar>]()
    
    var style: Style<UINavigationBar> {
        get {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return UINavigationBar._style[tmpAddress] ?? NavigationBarStyles.default
        } set {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            UINavigationBar._style[tmpAddress] = newValue
            newValue.apply(to: self)
        }
    }
}
