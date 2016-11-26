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
    
    enum fontSize: Int {
        case xsmall =       12
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
    
    enum clock: String {
        case min00 =     "\u{21}"
        case min03 =     "\u{22}"
        case min06 =     "\u{23}"
        case min09 =     "\u{24}"
        case min12 =     "\u{25}"
        case min15 =     "\u{26}"
        case min18 =     "\u{27}"
        case min21 =     "\u{28}"
        case min24 =     "\u{29}"
        case min27 =     "\u{2a}"
        case min30 =     "\u{2b}"
        case min33 =     "\u{2c}"
        case min36 =     "\u{2d}"
        case min39 =     "\u{2e}"
        case min42 =     "\u{2f}"
        case min45 =     "\u{30}"
        case min48 =     "\u{31}"
        case min51 =     "\u{32}"
        case min54 =     "\u{33}"
        case min57 =     "\u{34}"
        case hr12 =      "\u{35}"
        case hr01 =      "\u{36}"
        case hr02 =      "\u{37}"
        case hr03 =      "\u{38}"
        case hr04 =      "\u{39}"
        case hr05 =      "\u{3a}"
        case hr06 =      "\u{3b}"
        case hr07 =      "\u{3c}"
        case hr08 =      "\u{3d}"
        case hr09 =      "\u{3e}"
        case hr10 =      "\u{3f}"
        case hr11 =      "\u{40}"
        
    }
    
    enum iconSize: Int {
        case xxsmall = 20
        case xsmall = 24
        case small = 36
        case medium = 48
        case large = 72
    }
    
    enum iconFont: String {
        case material = "MaterialIcons-Regular"
        case clock = "pe-analogtime"
    }
    
    enum appFont: String {
        case regular =  "HelveticaNeue"
        case bold =     "HelveticaNeue-Bold"
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
