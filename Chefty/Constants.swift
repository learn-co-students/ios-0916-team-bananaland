//
//  Constants.swift
//  Chefty
//
//  Created by Paul Tangen on 10/23/16.
//  Copyright © 2016 Paul Tangen. All rights reserved.
//

import Foundation
import UIKit

struct Constants{
    
    enum fontSize: CGFloat {
        case xxsmall =      12
        case xsmall =       14
        case small =        16
        case medium =       18
        case large =        24
        case xlarge =       36
    }

    enum iconLibrary: String {
        case chevron_left =     "\u{E5CB}"
        case chevron_right =    "\u{E5CC}"
        case close =            "\u{E5CD}"
        case access_time =      "\u{E192}"
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
    
    enum appFont: String {
        case regular =  "HelveticaNeue"
        case bold =     "HelveticaNeue-Bold"
        case light =    "GillSans-Light"
    }
}

extension UIColor {
    enum ColorName : UInt32 {
        case red =      0x701220ff
        case blue =     0x336699ff
        case white =    0xffffffff
        case beige =    0xD7D2B9ff
        case black =    0x999999ff
        case gray3 =    0x333333ff
        case orange =   0xFF851Bff
        case disabledText =         0xCCCCCCff
        case headingbackground =    0x84202Bff   
        
        case titleGreen =           0xDFDAC5ff
        case lightPurpleGray =      0x8A7C8Bff
        case deepPurple =           0x23141Cff
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
