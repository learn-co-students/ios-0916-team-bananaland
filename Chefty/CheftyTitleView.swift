//
//  CheftyTitleView.swift
//  Chefty
//
//  Created by Arvin San Miguel on 12/6/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

class CheftyTitleView: UIView {

    override func draw(_ rect: CGRect) {
        CheftyTitle.drawTitle(frame: bounds, resizing: .aspectFill)
    }
}
