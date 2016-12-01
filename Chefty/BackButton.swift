//
//  BackButton.swift
//  Chefty
//
//  Created by Arvin San Miguel on 11/29/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

class BackButton: UIButton {

    override func draw(_ rect: CGRect) {
        
        BackButtonStyleKit.drawBackButton(frame: bounds, resizing: .stretch)
        
    }
    
    
    
}
