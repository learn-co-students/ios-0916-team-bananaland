//
//  SlidesButton.swift
//  Chefty
//
//  Created by Arvin San Miguel on 11/29/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

class SlidesButton: UIButton {

    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath(roundedRect: rect, cornerRadius: 5.0)
        UIColor.black.withAlphaComponent(0.7).setFill()
        path.fill()
        
    }

}
