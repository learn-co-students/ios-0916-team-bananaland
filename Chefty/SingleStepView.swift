//
//  SingleStepView.swift
//  Chefty
//
//  Created by Paul Tangen on 11/28/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

class SingleStepView: UIView {
    
    let store = DataStore.sharedInstance

    override init(frame:CGRect){
        super.init(frame: frame)
        CheftyAPIClient.getStepsAndIngredients(recipeIDRequest: "apple-pie") {
            print("Gettin' steps complete")
        
            for recipe in self.store.recipes {
                if "apple-pie" == recipe.id {
                    var allSteps = recipe.step?.allObjects as! [Steps]
                    for step in allSteps {
                        //print("TESTING DATA: \(step)")
                    }
                }
                
            }
        }
        
        let ingredients: [String] = ["2 1/2 cups all-purpose flour", "teaspoons sugar","1/4 teaspoon fine salt", "14 tablespoons cold butter, diced", "large egg", "large egg, lightly beaten with 2 tablespoons cold water"]
        
        // initialize controls
        let stepTitle: UILabel = UILabel()
        let ingredientsTitle: UILabel = UILabel()
        
        // configure controls
        stepTitle.text = "Make dough"
        stepTitle.font =  UIFont(name: "Helvetica", size: CGFloat(Constants.fontSize.large.rawValue))
        stepTitle.backgroundColor = UIColor.red
        
        ingredientsTitle.text = "Ingredients"
        ingredientsTitle.font =  UIFont(name: "Helvetica", size: CGFloat(Constants.fontSize.medium.rawValue))
        ingredientsTitle.backgroundColor = UIColor.red
        
        // add the object to the view
        self.addSubview(stepTitle)
        self.addSubview(ingredientsTitle)
        
        // constrain the object
        stepTitle.translatesAutoresizingMaskIntoConstraints = false
        stepTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 100).isActive = true
        stepTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        ingredientsTitle.translatesAutoresizingMaskIntoConstraints = false
        ingredientsTitle.topAnchor.constraint(equalTo: stepTitle.topAnchor, constant: 60).isActive = true
        ingredientsTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
