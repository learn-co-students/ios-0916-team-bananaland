//
//  MenuViewButton.swift
//  Chefty
//
//  Created by Arvin San Miguel on 11/28/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import Foundation

@IBDesignable
class MenuViewButton : UIButton {
    
    override func draw(_ rect: CGRect) {
        
        let lineWidth: CGFloat = 2
        
        //StyleKitName.drawMainDish(frame: bounds, resizing: .aspectFill)
        let insetRect = rect.insetBy(dx: lineWidth / 2, dy: lineWidth / 2)
        let path = UIBezierPath(ovalIn: insetRect)
        path.lineWidth = 2.0
        UIColor.white.setStroke()
        path.stroke()
        
        
    }
    
    func selected() {
        
        //StyleKitName.drawSelectedMainDish()
        
    }

}
