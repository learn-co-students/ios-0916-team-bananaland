//
//  Constants.swift
//  YarnCafe
//
//  Created by Paul Tangen on 10/23/16.
//  Copyright © 2016 Paul Tangen. All rights reserved.
//

import Foundation
import UIKit

struct Constants{
    
    enum fontSize: Int {
        case small = 16
        case medium = 24
        case large = 36
        case xlarge = 48
    }

  
    enum iconLibrary: String {
        case chevron_left =     "\u{E5CB}"
        case chevron_right =    "\u{E5CC}"
        case close =            "\u{E5CD}"
    }
    
    enum iconSize: Int {
        case xsmall = 24
        case small = 36
        case medium = 48
        case large = 72
    }
    
    enum iconFont: String {
        case material = "MaterialIcons-Regular"
    }
}

extension UIColor {
    enum ColorName : UInt32 {
        case red =      0xcc3333ff
        case blue =     0x336699ff
        case white =    0xffffffff
        case beige =    0xf7e5c5ff
        case black =    0x999999ff
        case gray3 =    0x333333ff
        case orange =   0xFF851Bff
    }
}

extension UIColor {
    convenience init(named name: ColorName) {
        let rgbaValue = name.rawValue
        let red   = CGFloat((rgbaValue >> 24) & 0xff) / 255.0
        let green = CGFloat((rgbaValue >> 16) & 0xff) / 255.0
        let blue  = CGFloat((rgbaValue >>  8) & 0xff) / 255.0
        let alpha = CGFloat((rgbaValue      ) & 0xff) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}