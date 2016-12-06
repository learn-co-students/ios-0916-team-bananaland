//
//  CookButton.swift
//  Chefty
//
//  Created by Arvin San Miguel on 11/30/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit


class CookButton: UIButton {

    override func draw(_ rect: CGRect) {
        CookButtonStyleKit.drawCookButton(frame: bounds, resizing: .stretch)
    }

}
