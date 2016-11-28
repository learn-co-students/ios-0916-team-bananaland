//
//  SingleStepView.swift
//  Chefty
//
//  Created by Paul Tangen on 11/28/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

class SingleStepView: UIView {

    override init(frame:CGRect){
        super.init(frame: frame)
        
        let ingredients: [String] = ["2 1/2 cups all-purpose flour", "teaspoons sugar","1/4 teaspoon fine salt", "14 tablespoons cold butter, diced", "large egg", "large egg, lightly beaten with 2 tablespoons cold water"]
        
        // initialize button
        let stepTitle: UILabel = UILabel()
        
        // configure controls
        stepTitle.text = "Make dough"
        stepTitle.font =  UIFont(name: "Helvetica", size: CGFloat(Constants.fontSize.large.rawValue))
        
        // add the object to the view
        self.addSubview(stepTitle)
        
        // constrain the object
        stepTitle.translatesAutoresizingMaskIntoConstraints = false
        stepTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 100).isActive = true
        stepTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
