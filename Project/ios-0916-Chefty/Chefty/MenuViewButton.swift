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
        
        let path = UIBezierPath(ovalIn: rect)
        UIColor.black.setFill()
        path.fill()
        
    }

}
