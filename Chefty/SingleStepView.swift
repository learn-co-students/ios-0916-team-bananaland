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
    var sampleStep: Steps?
    var procedureBody: String = String()
    var duration: Int32 = Int32()
    var stepTitle: String = String()

    override init(frame:CGRect){
        super.init(frame: frame)
        CheftyAPIClient.getStepsAndIngredients(recipeIDRequest: "apple-pie") {
        
            // print the content of the requested recipe

            for recipe in self.store.recipes {
                if "apple-pie" == recipe.id {
                    print(recipe.imageURLSmall)
                    let allSteps = recipe.step?.allObjects as! [Steps]
                    for step in allSteps {
                        print("\n")
                        print("stepTitle: \(step.stepTitle!)")
                        print("stepNumber: \(step.stepNumber)")
                        print("timeToStart: \(step.timeToStart)")
                        print("duration: \(step.duration)")
                        print("fullAttentionRequired: \(step.fullAttentionRequired)")
                        print("procedure: \(step.procedure!)")
                        if let ingredientsAny = step.ingredient {
                            for ingredientAny in ingredientsAny {
                                let ingredient = ingredientAny as? Ingredient;
                                if let ingredientUnwrapped = ingredient {
                                    print("ingredientDescription: \(ingredientUnwrapped.ingredientDescription)")
                                    print("ingredientIsChecked: \(ingredientUnwrapped.isChecked)")
                                }
                            }
                        }
                    }
                }
            }
        
          //build an array of recipeSteps
          let stepsFromRecipe1:[Steps] = self.store.recipes.first!.step!.allObjects as! [Steps]
          let stepsFromRecipe2:[Steps] = self.store.recipes.last!.step!.allObjects as! [Steps]
          let stepsFromBothRecipes = stepsFromRecipe1 + stepsFromRecipe2
        
          print("stepsFromBothRecipes.count: \(stepsFromBothRecipes.count)")
        
          print("procedureFromStep: \(stepsFromBothRecipes.first?.procedure)")
        
          print("step's recipe: \(stepsFromBothRecipes.first?.recipe?.id)")
        
            
            // get the steps
            let sampleSteps:[Steps] = self.store.recipes.first!.step!.allObjects as! [Steps]
            
            // get step 1
            for step in sampleSteps {
                step.stepNumber == 1 ? self.sampleStep = step : ()
            }
            
            // unwrap values
            if let procedureBody = self.sampleStep?.procedure {
                self.procedureBody = procedureBody
            }
            
            if let duration = self.sampleStep?.duration {
                self.duration = duration
            }
            
            if let stepTitle = self.sampleStep?.stepTitle {
                self.stepTitle = stepTitle
            }
            
        }
        
        let ingredients: [String] = ["2 1/2 cups all-purpose flour", "teaspoons sugar","1/4 teaspoon fine salt", "14 tablespoons cold butter, diced", "large egg", "large egg, lightly beaten with 2 tablespoons cold water"]
        
        // initialize controls
        let stepTitle: UILabel = UILabel()
        let timeRemaingLabel: UILabel = UILabel()
        let ingredientsTitle: UILabel = UILabel()
        let ingredientsBody: UITextView = UITextView()
        let procedureTitle: UILabel = UILabel()
        let procedureBody: UITextView = UITextView()
        
        // configure controls
        stepTitle.text = self.stepTitle
        stepTitle.font =  UIFont(name: Constants.appFont.bold.rawValue, size: Constants.fontSize.large.rawValue)
        //stepTitle.backgroundColor = UIColor.red
        
        timeRemaingLabel.text = "Time remaining in step 1: \(duration) seconds"
        timeRemaingLabel.font = UIFont(name: Constants.appFont.regular.rawValue, size: Constants.fontSize.xsmall.rawValue)
        //timeRemaingLabel.backgroundColor = UIColor.red
        
        ingredientsTitle.text = "Ingredients"
        ingredientsTitle.font =  UIFont(name: Constants.appFont.bold.rawValue, size: Constants.fontSize.medium.rawValue)
        //ingredientsTitle.backgroundColor = UIColor.red
        
        ingredientsBody.text = "2 1/2 cups all-purpose flour \nteaspoons sugar \n1/4 teaspoon fine salt \n14 tablespoons cold butter, diced  \nlarge egg, lightly beaten with 2 tablespoons cold water"
        ingredientsBody.font =  UIFont(name: Constants.appFont.regular.rawValue, size: Constants.fontSize.small.rawValue)
        //ingredientsBody.backgroundColor = UIColor.red
        ingredientsBody.isUserInteractionEnabled = false
        
        procedureTitle.text = "Procedure"
        procedureTitle.font =  UIFont(name: Constants.appFont.bold.rawValue, size: Constants.fontSize.medium.rawValue)
        //procedureTitle.backgroundColor = UIColor.red
        
        procedureBody.text = self.procedureBody
        procedureBody.font =  UIFont(name: Constants.appFont.regular.rawValue, size: Constants.fontSize.small.rawValue)
        //procedureBody.backgroundColor = UIColor.red
        procedureBody.isUserInteractionEnabled = false
        
        // add the object to the view
        self.addSubview(stepTitle)
        self.addSubview(timeRemaingLabel)
        self.addSubview(ingredientsTitle)
        self.addSubview(ingredientsBody)
        self.addSubview(procedureTitle)
        self.addSubview(procedureBody)
        
        // constrain the object
        stepTitle.translatesAutoresizingMaskIntoConstraints = false
        stepTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 100).isActive = true
        stepTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        timeRemaingLabel.translatesAutoresizingMaskIntoConstraints = false
        timeRemaingLabel.topAnchor.constraint(equalTo: stepTitle.topAnchor, constant: 60).isActive = true
        timeRemaingLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        
        ingredientsTitle.translatesAutoresizingMaskIntoConstraints = false
        ingredientsTitle.topAnchor.constraint(equalTo: timeRemaingLabel.bottomAnchor, constant: 40).isActive = true
        ingredientsTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        
        ingredientsBody.translatesAutoresizingMaskIntoConstraints = false
        ingredientsBody.topAnchor.constraint(equalTo: ingredientsTitle.bottomAnchor, constant:0).isActive = true
        ingredientsBody.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        ingredientsBody.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        ingredientsBody.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2).isActive = true
        
        procedureTitle.translatesAutoresizingMaskIntoConstraints = false
        procedureTitle.topAnchor.constraint(equalTo: ingredientsBody.bottomAnchor, constant: 40).isActive = true
        procedureTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        
        procedureBody.translatesAutoresizingMaskIntoConstraints = false
        procedureBody.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        procedureBody.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        procedureBody.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        procedureBody.topAnchor.constraint(equalTo: procedureTitle.bottomAnchor, constant: 0).isActive = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
