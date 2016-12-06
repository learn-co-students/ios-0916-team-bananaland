//
//  PersonIconView.swift
//  Chefty
//
//  Created by Arvin San Miguel on 12/5/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

class PersonIconView: UIView {

    override func draw(_ rect: CGRect) {
        PersonIcon.drawPersonIcon(frame: bounds, resizing: .aspectFill)
    }

}
