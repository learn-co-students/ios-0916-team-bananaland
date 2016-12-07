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
    var currentStepInst: Steps?
    var procedureBody: String = String()
    var expectedStepCompletion: String = String()
    var stepTitle: String = String()
    var ingredients: String = String()
    var recipeImage: UIImage = UIImage()
    var imageURLString: String = String()
    
    // initialize controls
    let stepTitleLabel: UILabel = UILabel()
    let timeRemaingLabel: UILabel = UILabel()
    let expectedStepCompletionLabel: UILabel = UILabel()
    let ingredientsTitle: UILabel = UILabel()
    let ingredientsBody: UILabel = UILabel()
    let procedureTitle: UILabel = UILabel()
    let procedureBodyTextView: UITextView = UITextView()
    let recipeUIImageView: UIImageView = UIImageView()
    let doneButton: UIButton = UIButton()

    override init(frame:CGRect){
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        print("***** SingleStepView *******")
        
//        CheftyAPIClient.getStepsAndIngredients(recipeIDRequest: "apple-pie") {
        
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

        
        
        
        // get the expected completion time for the step
        let tempMergedStepsArray = self.store.mergedStepsArray
        let remainingStepsArray: [Steps] = Array(self.store.mergedStepsArray.dropFirst(UserDefaults.standard.integer(forKey: "stepCurrent")))
        self.store.mergedStepsArray = remainingStepsArray
        store.calculateStartTime()
        self.expectedStepCompletion = store.startCookingTime // now we have the completion time as if this were the first step
        self.store.mergedStepsArray = tempMergedStepsArray // restore the mergedStepsArray
        store.calculateStartTime() // restore the start time for the all steps
        
        // unwrap values
        if let procedureBody = self.store.mergedStepsArray[UserDefaults.standard.integer(forKey: "stepCurrent")-1].procedure {
            self.procedureBody = procedureBody
        }
        
        if let stepTitle = self.store.mergedStepsArray[UserDefaults.standard.integer(forKey: "stepCurrent")-1].stepTitle {
            self.stepTitle = stepTitle
        }
        
        if let ingredientsAny = self.store.mergedStepsArray[UserDefaults.standard.integer(forKey: "stepCurrent")-1].ingredient {
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
        
        if let url = self.store.mergedStepsArray[UserDefaults.standard.integer(forKey: "stepCurrent")-1].recipe?.imageURLSmall {
            self.imageURLString = url
            guard let url = URL(string: self.imageURLString) else { return }
            self.recipeUIImageView.contentMode = .scaleAspectFill
            self.recipeUIImageView.sd_setImage(with: url)
        }
        
        // configure controls
        self.stepTitleLabel.text = self.stepTitle
        self.stepTitleLabel.textAlignment = .center
        self.stepTitleLabel.textColor = UIColor(red: 255/255, green: 255/255, blue: 238/255, alpha: 1.0)
        self.stepTitleLabel.font =  UIFont(name: "GillSans-Light", size: 30)
        self.stepTitleLabel.backgroundColor = UIColor(named: UIColor.ColorName(rawValue: UIColor.ColorName.deepPurple.rawValue)!)
        
        //***
        self.expectedStepCompletionLabel.text = "Complete step by \(self.expectedStepCompletion)"
        //self.expectedStepCompletionLabel.font = UIFont(name: Constants.appFont.regular.rawValue, size: Constants.fontSize.xsmall.rawValue)
        self.expectedStepCompletionLabel.font = UIFont(name: "GillSans-Light", size: 24)
        
        
        self.ingredientsTitle.text = "Ingredients"
        self.ingredientsTitle.textAlignment = .center
        self.ingredientsTitle.font = UIFont(name: "GillSans-Light", size: 25)
        self.ingredientsTitle.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 238/255, alpha: 1.0)
        self.ingredientsTitle.textColor = UIColor.black

        
        //***
        self.ingredientsBody.text = self.ingredients
        self.ingredientsBody.font =  UIFont(name: Constants.appFont.regular.rawValue, size: Constants.fontSize.small.rawValue)
        
        
        self.procedureTitle.text = "Procedure"
        //***
        //self.procedureTitle.font =  UIFont(name: Constants.appFont.bold.rawValue, size: Constants.fontSize.medium.rawValue)
        self.procedureTitle.font =  UIFont(name: "GillSans-Light", size: 25)
        self.procedureTitle.backgroundColor = UIColor(red: 132/255.0, green: 32/255.0, blue: 43/255.0, alpha: 1.0)
        self.procedureTitle.textColor = UIColor.black

        

        self.procedureBodyTextView.text = self.procedureBody
        self.procedureBodyTextView.font =  UIFont(name: Constants.appFont.regular.rawValue, size: Constants.fontSize.small.rawValue)
        self.procedureBodyTextView.backgroundColor = UIColor.white
            //UIColor(red: 215/255, green: 210/255, blue: 185/255, alpha: 1.0)
        
        let range = NSMakeRange(self.procedureBodyTextView.text.characters.count - 1, 0)
        self.procedureBodyTextView.scrollRangeToVisible(range)
        self.procedureBodyTextView.isUserInteractionEnabled = false
        
        
        self.doneButton.titleLabel!.font =  UIFont(name: Constants.appFont.regular.rawValue, size: CGFloat(Constants.fontSize.small.rawValue))
        self.doneButton.addTarget(self, action: #selector(SingleStepView.onClickNextStep), for: .touchUpInside)
        if UserDefaults.standard.integer(forKey: "stepCurrent") == self.store.mergedStepsArray.count { // if on the last step, disable to next step button
            self.doneButton.isEnabled = false
            self.doneButton.setTitleColor(UIColor(named: .disabledText), for: .disabled)
            self.doneButton.setTitle("All steps complete.", for: .normal)
        } else {
            self.doneButton.isEnabled = true
            self.doneButton.setTitleColor(self.tintColor, for: .normal)
            self.doneButton.setTitle("Completed procedure, go to step \(UserDefaults.standard.integer(forKey: "stepCurrent") + 1)", for: .normal)
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
        self.addSubview(self.expectedStepCompletionLabel)
        
        // constrain the objects
        self.recipeUIImageView.translatesAutoresizingMaskIntoConstraints = false
        self.recipeUIImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 64).isActive = true
        self.recipeUIImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.recipeUIImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        self.recipeUIImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        self.stepTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.stepTitleLabel.topAnchor.constraint(equalTo: self.recipeUIImageView.topAnchor).isActive = true
        self.stepTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.stepTitleLabel.rightAnchor.constraint(equalTo: self.recipeUIImageView.leftAnchor).isActive = true
        self.stepTitleLabel.bottomAnchor.constraint(equalTo: self.recipeUIImageView.bottomAnchor).isActive = true
        self.stepTitleLabel.numberOfLines = 0
        self.stepTitleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        self.expectedStepCompletionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.expectedStepCompletionLabel.topAnchor.constraint(equalTo: self.stepTitleLabel.bottomAnchor, constant: 20).isActive = true
        self.expectedStepCompletionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        
        self.ingredientsTitle.translatesAutoresizingMaskIntoConstraints = false
        self.ingredientsTitle.topAnchor.constraint(equalTo: self.stepTitleLabel.bottomAnchor, constant: 40).isActive = true
        self.ingredientsTitle.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.ingredientsTitle.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        if let text = self.ingredientsBody.text {
            text.isEmpty ? self.ingredientsTitle.text = "" : ()
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
    }
    
    func onClickNextStep(){
        if UserDefaults.standard.integer(forKey: "stepCurrent") < self.store.mergedStepsArray.count {
            let nextStep:Int = Int(UserDefaults.standard.integer(forKey: "stepCurrent")) + 1
            UserDefaults.standard.set(nextStep, forKey: "stepCurrent")
            self.delegate?.goToNextStep()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
