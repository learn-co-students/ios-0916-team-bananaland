//
//  ShowIngredientButton.swift
//  Chefty
//
//  Created by Arvin San Miguel on 12/1/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

class ShowIngredientButton: UIButton {

    override func draw(_ rect: CGRect) {
        ShowIngredientStyleKit.drawShowIngredients(frame: bounds, resizing: .stretch)
    }

}
