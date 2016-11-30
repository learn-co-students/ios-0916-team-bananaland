//
//  SelectedRecipeButton.swift
//  Chefty
//
//  Created by Arvin San Miguel on 11/26/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

class SelectedRecipeButton: UIButton {

    var fillColor = UIColor.black.withAlphaComponent(0.5)
    var roundFillColor = UIColor.gray
    var isAddButton = true
    
    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath(ovalIn: rect)
        roundFillColor.setFill()
        path.fill()
     
        let linePath = UIBezierPath()
        linePath.lineWidth = 1.0
        linePath.move(to: CGPoint(x: bounds.width * 0.5, y: bounds.height * 0.20))
        linePath.addLine(to: CGPoint(x: bounds.width * 0.5, y: bounds.height * 0.80))
        
        if isAddButton {
            linePath.move(to: CGPoint(x: bounds.width * 0.2, y: bounds.height * 0.50))
            linePath.addLine(to: CGPoint(x: bounds.width * 0.8, y: bounds.height * 0.50))
        }
        
        fillColor.setStroke()
        linePath.stroke()
        
    }
    
}
