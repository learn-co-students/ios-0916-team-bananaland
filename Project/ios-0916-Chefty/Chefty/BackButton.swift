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
        
        let lineWidth: CGFloat = 2
        let insetRect = rect.insetBy(dx: lineWidth / 2, dy: lineWidth / 2)
        let path = UIBezierPath(ovalIn: insetRect)
        path.lineWidth = 2.0
        UIColor.black.withAlphaComponent(0.7).setFill()
        UIColor.black.setStroke()
        path.fill()
        path.stroke()
        
    }
    
    
    
}
