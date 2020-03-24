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
        $0.titleTextAttributes = [.foregroundColor: UIColor.black, .font: UIFont.systemFontSize]
    }
}

final class Style<V> where V: UIView {
    let style: (V) -> Void
    
    init(_ style: @escaping (V) -> Void) {
        self.style = style
    }
    
    func apply(to view: V) {
        style(view)
    }
}
