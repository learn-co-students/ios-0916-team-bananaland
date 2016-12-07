//
//  RemoveButtonView.swift
//  Chefty
//
//  Created by Arvin San Miguel on 12/6/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

class RemoveButtonView: UIButton {

    override func draw(_ rect: CGRect) {
        RemoveButton.drawRemoveButton(frame: bounds, resizing: .stretch)
    }

}
