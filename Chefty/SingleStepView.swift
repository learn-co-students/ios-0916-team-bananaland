//
//  SingleStepView.swift
//  Chefty
//
//  Created by Paul Tangen on 11/28/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

protocol SingleStepDelegate: class {
    func goToNextStep()
}

class SingleStepView: UIView {
    
    weak var delegate: SingleStepDelegate?
    let store = DataStore.sharedInstance
    var sampleStep: Steps?
    var procedureBody: String = String()
    var duration: Int32 = Int32()
    var stepTitle: String = String()
    var ingredients: String = String()
    var recipeImage: UIImage = UIImage()
    var imageURLString: String = String()
    
    // initialize controls
    let stepTitleLabel: UILabel = UILabel()
    let timeRemaingLabel: UILabel = UILabel()
    let ingredientsTitle: UILabel = UILabel()
    let ingredientsBody: UILabel = UILabel()
    let procedureTitle: UILabel = UILabel()
    let procedureBodyTextView: UITextView = UITextView()
    let recipeUIImageView: UIImageView = UIImageView()
    let doneButton: UIButton = UIButton()

    override init(frame:CGRect){
        print("init view")
        super.init(frame: frame)
        
        CheftyAPIClient.getStepsAndIngredients(recipeIDRequest: "apple-pie") {
        
            // print the content of the requested recipe

//            for recipe in self.store.recipes {
//                if "apple-pie" == recipe.id {
//                    print(recipe.imageURLSmall)
//                    let allSteps = recipe.step?.allObjects as! [Steps]
//                    for step in allSteps {
//                        print("\n")
//                        print("stepTitle: \(step.stepTitle!)")
//                        print("stepNumber: \(step.stepNumber)")
//                        print("timeToStart: \(step.timeToStart)")
//                        print("duration: \(step.duration)")
//                        print("fullAttentionRequired: \(step.fullAttentionRequired)")
//                        print("procedure: \(step.procedure!)")
//                        if let ingredientsAny = step.ingredient {
//                            for ingredientAny in ingredientsAny {
//                                let ingredient = ingredientAny as? Ingredient;
//                                if let ingredientUnwrapped = ingredient {
//                                    print("ingredientDescription: \(ingredientUnwrapped.ingredientDescription)")
//                                    print("ingredientIsChecked: \(ingredientUnwrapped.isChecked)")
//                                }
//                            }
//                        }
//                    }
//                }
//            }
        
            
            //build an array of recipeSteps
            let stepsFromRecipe1:[Steps] = self.store.recipes.first!.step!.allObjects as! [Steps]
            let stepsFromRecipe2:[Steps] = self.store.recipes.last!.step!.allObjects as! [Steps]
            let stepsFromBothRecipes = stepsFromRecipe1 + stepsFromRecipe2
        
            //print("stepsFromBothRecipes.count: \(stepsFromBothRecipes.count)")
            //print("procedureFromStep: \(stepsFromBothRecipes.first?.procedure)")
            //print("step's recipe: \(stepsFromBothRecipes.first?.recipe?.id)")
            
            // get the steps
            let sampleSteps:[Steps] = self.store.recipes.first!.step!.allObjects as! [Steps]
            //print("mergedStepArray: \(self.store.mergedStepsArray.first!.description)")
            
            // iterate through the steps and get the next one
            print("self.store.stepCurrent: \(self.store.stepCurrent)")
            for step in sampleSteps {
                if Int(step.stepNumber) == self.store.stepCurrent {
                    self.sampleStep = step
                    break
                }
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
            
            if let ingredientsAny = self.sampleStep?.ingredient {
                // the ingredients are in an array of ingredients objects, extract the descriptions and place in a string for display
                let ingredientsArr = ingredientsAny.allObjects as? [Ingredient]
                if ingredientsArr?.isEmpty == false {
                    for ingredient in ingredientsArr! {
                        if let desc = ingredient.ingredientDescription {
                            self.ingredients += "- \(desc)\n"
                        }
                    }
                }
            }
            
            if let url = self.sampleStep?.recipe?.imageURLSmall {
                self.imageURLString = url
            }

            // configure controls
            self.stepTitleLabel.text = self.stepTitle
            self.stepTitleLabel.font =  UIFont(name: Constants.appFont.bold.rawValue, size: Constants.fontSize.large.rawValue)

            guard let url = URL(string: self.imageURLString) else { fatalError() }
            self.recipeUIImageView.contentMode = .scaleAspectFill
            self.recipeUIImageView.sd_setImage(with: url)
        
            self.timeRemaingLabel.text = "Time remaining in step \(self.store.stepCurrent): \(self.duration) minutes."
            self.timeRemaingLabel.font = UIFont(name: Constants.appFont.regular.rawValue, size: Constants.fontSize.xsmall.rawValue)

            self.ingredientsTitle.text = "Ingredients"
            self.ingredientsTitle.font =  UIFont(name: Constants.appFont.bold.rawValue, size: Constants.fontSize.medium.rawValue)
            
            self.ingredientsBody.text = self.ingredients
            self.ingredientsBody.font =  UIFont(name: Constants.appFont.regular.rawValue, size: Constants.fontSize.small.rawValue)
            
            self.procedureTitle.text = "Procedure"
            self.procedureTitle.font =  UIFont(name: Constants.appFont.bold.rawValue, size: Constants.fontSize.medium.rawValue)
        
            self.procedureBodyTextView.text = self.procedureBody
            self.procedureBodyTextView.font =  UIFont(name: Constants.appFont.regular.rawValue, size: Constants.fontSize.small.rawValue)
            let range = NSMakeRange(self.procedureBodyTextView.text.characters.count - 1, 0)
            self.procedureBodyTextView.scrollRangeToVisible(range)
            
            self.doneButton.setTitle("Completed Procedure, Go to Step \(self.store.stepCurrent + 1)", for: .normal)
            self.doneButton.titleLabel!.font =  UIFont(name: Constants.appFont.regular.rawValue, size: CGFloat(Constants.fontSize.small.rawValue))
            self.doneButton.addTarget(self, action: #selector(SingleStepView.onClickNextStep), for: .touchUpInside)
            if self.store.stepCurrent == self.store.stepTotal { // if on the last step, disable to next step button
                self.doneButton.isEnabled = false
                self.doneButton.setTitleColor(UIColor(named: .disabledText), for: .disabled)
            } else {
                self.doneButton.isEnabled = true
                self.doneButton.setTitleColor(self.tintColor, for: .normal)   //, for: .normal)
            }

            // add objects to the view
            self.addSubview(self.stepTitleLabel)
            self.addSubview(self.recipeUIImageView)
            self.addSubview(self.timeRemaingLabel)
            self.addSubview(self.ingredientsTitle)
            self.addSubview(self.ingredientsBody)
            self.addSubview(self.procedureTitle)
            self.addSubview(self.procedureBodyTextView)
            self.addSubview(self.doneButton)
        
            // constrain the objects
            self.recipeUIImageView.translatesAutoresizingMaskIntoConstraints = false
            self.recipeUIImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 60).isActive = true
            self.recipeUIImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
            self.recipeUIImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2).isActive = true
            self.recipeUIImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 200).isActive = true
            self.recipeUIImageView.contentMode = UIViewContentMode.scaleAspectFill
            self.recipeUIImageView.backgroundColor = UIColor.brown
            
            self.stepTitleLabel.translatesAutoresizingMaskIntoConstraints = false
            self.stepTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 100).isActive = true
            self.stepTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
            self.stepTitleLabel.rightAnchor.constraint(equalTo: self.recipeUIImageView.leftAnchor, constant: -40).isActive = true
            self.stepTitleLabel.numberOfLines = 0
            self.stepTitleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
       
            self.timeRemaingLabel.translatesAutoresizingMaskIntoConstraints = false
            self.timeRemaingLabel.topAnchor.constraint(equalTo: self.stepTitleLabel.topAnchor, constant: 60).isActive = true
            self.timeRemaingLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        
            self.ingredientsTitle.translatesAutoresizingMaskIntoConstraints = false
            self.ingredientsTitle.topAnchor.constraint(equalTo: self.timeRemaingLabel.bottomAnchor, constant: 40).isActive = true
            self.ingredientsTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
            self.ingredientsTitle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
            if let text = self.ingredientsBody.text {
                text.isEmpty ? self.ingredientsTitle.text = "" : print("ingredients exist")
            }
        
            self.ingredientsBody.translatesAutoresizingMaskIntoConstraints = false
            self.ingredientsBody.topAnchor.constraint(equalTo: self.ingredientsTitle.bottomAnchor, constant: 0).isActive = true
            self.ingredientsBody.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
            self.ingredientsBody.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
            self.ingredientsBody.numberOfLines = 0
            self.ingredientsBody.lineBreakMode = NSLineBreakMode.byWordWrapping
            
            self.doneButton.translatesAutoresizingMaskIntoConstraints = false
            self.doneButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
            self.doneButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12).isActive = true
            self.doneButton.heightAnchor.constraint(equalToConstant: 20).isActive = true

            self.procedureTitle.translatesAutoresizingMaskIntoConstraints = false
            self.procedureTitle.topAnchor.constraint(equalTo: self.ingredientsBody.bottomAnchor, constant: 20).isActive = true
            self.procedureTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
            
            self.procedureBodyTextView.translatesAutoresizingMaskIntoConstraints = false
            self.procedureBodyTextView.topAnchor.constraint(equalTo: self.procedureTitle.bottomAnchor, constant: 0).isActive = true
            self.procedureBodyTextView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 7).isActive = true
            self.procedureBodyTextView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -7).isActive = true
            self.procedureBodyTextView.bottomAnchor.constraint(equalTo: self.doneButton.bottomAnchor, constant: -40).isActive = true
            
        } //end of closure
    }
    
    func onClickNextStep(){
        if store.stepCurrent < self.store.stepTotal {
            self.store.stepCurrent += 1
            print("stepCurrent changed to \(self.store.stepCurrent)")
            self.delegate?.goToNextStep()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
