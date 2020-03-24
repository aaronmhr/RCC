//
//  UIFont+Style.swift
//  RCC
//
//  Created by Aaron Huánuco on 24/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import UIKit

extension UIFont {
    static var regular14: UIFont {
        return Fonts.robotoRegular(ofSize: 14)
    }
    
    static var regular16: UIFont {
        return Fonts.robotoRegular(ofSize: 16)
    }
    
    static var regular20: UIFont {
        return Fonts.robotoRegular(ofSize: 20)
    }
    
    private enum Fonts {
        static func robotoRegular(ofSize size: CGFloat) -> UIFont {
            return UIFont(name: "Roboto-Regular", size: size) ?? systemFont(ofSize: size)
        }
    }
}
