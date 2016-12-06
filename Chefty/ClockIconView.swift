//
//  ClockIconView.swift
//  Chefty
//
//  Created by Arvin San Miguel on 12/5/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

class ClockIconView: UIView {

    override func draw(_ rect: CGRect) {
        ClockIcon.drawClockIcon(frame: bounds, resizing: .aspectFit)
    }

}
    
