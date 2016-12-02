//
//  CookItButton.swift
//  Chefty
//
//  Created by Arvin San Miguel on 12/1/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

class CookItButton: UIButton {

    override func draw(_ rect: CGRect) {
        CookItButtonStyleKit.drawCookItButton(frame: bounds, resizing: .aspectFit)
    }

}
