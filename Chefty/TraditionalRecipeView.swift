//
//  TraditionalRecipeView.swift
//  Chefty
//
//  Created by Jacqueline Minneman on 11/17/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//


import UIKit


class TraditionalRecipeView: UIView {
    
    var recipe: Recipe?
    var ingredientsArray: [String] = []
    var stepsArray: [String] = []
    var combinedSteps: String = ""
    var combinedIngredients: String = ""
    var totalTime: Int = 0
    var gradientView : GradientView!
    var totalTimeString = ""
    
    var myScrollView = UIScrollView()
    let recipeLabel = UILabel()
    
    init(frame:CGRect, recipe: Recipe){
        super.init(frame: frame)
        self.recipe = recipe
    
        CheftyAPIClient.getStepsAndIngredients(recipe: recipe, completion: {
            
        })
        
        self.getStepsandIngredients()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func getStepsandIngredients() {
        
        guard let recipe = self.recipe else { return }
        
        
        CheftyAPIClient.getStepsAndIngredients(recipe: recipe) {
            
            
            guard let recipeStep = recipe.steps else { return }
            
            var steps = recipeStep.allObjects as! [Step]
            
            steps = steps.sorted(by: { $0.timeToStart < $1.timeToStart } )
            
            for step in steps {
                guard let procedure = step.procedure else { return }
                self.stepsArray.append(procedure)
                
                self.totalTime += Int(step.duration)
                
                
                guard let stepIngredient = step.ingredients else { return }
                
                
                let ingredientsPerStep = stepIngredient.allObjects as! [Ingredient]
                if ingredientsPerStep.isEmpty == false {
                    
                    for ingredient in ingredientsPerStep {
                        guard let ingredientDescription = ingredient.ingredientDescription else { return }
                        self.ingredientsArray.append(ingredientDescription)
                    }
                }
            }
            
            self.combinedSteps = self.stepsArray.joined(separator: "\n\n")
            self.combinedIngredients = self.ingredientsArray.joined(separator: "\n")
            
            // after everything is complete move setup to the main thread so we see the results
            OperationQueue.main.addOperation {
                self.setUpElements()
            }
            
        }
    }
    
    
    func setUpElements() {
        
        guard let recipe = self.recipe else { return }
        
        //SCROLLVIEW
        self.myScrollView.backgroundColor = UIColor.clear
        self.addSubview(myScrollView)
        self.sendSubview(toBack: myScrollView)
        
        
        self.myScrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.myScrollView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.myScrollView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        self.myScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        //IMAGE
        // create image
        let myImageView = UIImageView()
        self.myScrollView.addSubview(myImageView)
        
        // constrain the image
        myImageView.heightAnchor.constraint(equalTo: myScrollView.heightAnchor, multiplier: 0.6).isActive = true
        myImageView.widthAnchor.constraint(equalTo: myScrollView.widthAnchor).isActive = true
        myImageView.topAnchor.constraint(equalTo: myScrollView.topAnchor).isActive = true
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        myImageView.contentMode = .scaleAspectFill
        
        let bgView = GradientView()
        self.myScrollView.addSubview(bgView)
        
        bgView.translatesAutoresizingMaskIntoConstraints = false
        bgView.topAnchor.constraint(equalTo: myScrollView.topAnchor).isActive = true
        bgView.widthAnchor.constraint(equalTo: myScrollView.widthAnchor, multiplier: 1).isActive = true
        bgView.heightAnchor.constraint(equalTo: myScrollView.heightAnchor, multiplier: 0.6).isActive = true
        
        // grab image from URL
        //let imageURL = URL(string: recipe.imageURL!)
        let imageURL = URL(string: recipe.imageURL!)
        myImageView.sd_setImage(with: imageURL!)
        self.sendSubview(toBack: myImageView)
        
        //RECIPE TITLE
        //create title label
        self.recipeLabel.text = recipe.displayName
        self.recipeLabel.numberOfLines = 0
        self.recipeLabel.font = UIFont(name: Constants.appFont.light.rawValue, size: 25)
        self.recipeLabel.textColor = UIColor.white
        self.recipeLabel.textAlignment = .center
        self.myScrollView.addSubview(self.recipeLabel)
        
        // constrain label
        recipeLabel.bottomAnchor.constraint(equalTo: myImageView.bottomAnchor).isActive = true
        recipeLabel.widthAnchor.constraint(equalTo: myImageView.widthAnchor, multiplier: 1.0).isActive = true
        recipeLabel.heightAnchor.constraint(equalTo: myImageView.heightAnchor, multiplier: 0.2).isActive = true
        recipeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //
        let bgView2 = UIView()
        bgView2.backgroundColor = UIColor.black
        self.myScrollView.addSubview(bgView2)
        
        bgView2.widthAnchor.constraint(equalTo: myScrollView.widthAnchor, multiplier: 1.0).isActive = true
        bgView2.heightAnchor.constraint(equalTo: myImageView.heightAnchor, multiplier: 0.2).isActive = true
        bgView2.topAnchor.constraint(equalTo: myImageView.bottomAnchor, constant: 0).isActive = true
        bgView2.translatesAutoresizingMaskIntoConstraints = false
        
        //Insert Person Icon
        let personIcon = PersonIconView()
        self.myScrollView.addSubview(personIcon)
        
        personIcon.leftAnchor.constraint(equalTo: myScrollView.leftAnchor, constant: 20).isActive = true
        personIcon.topAnchor.constraint(equalTo: bgView2.topAnchor).isActive = true
        personIcon.widthAnchor.constraint(equalTo: myScrollView.widthAnchor, multiplier: 0.1).isActive = true
        personIcon.heightAnchor.constraint(equalToConstant: 30).isActive = true
        personIcon.translatesAutoresizingMaskIntoConstraints = false
        
        //Insert Clock Icon
        let clockIcon = ClockIconView()
        self.myScrollView.addSubview(clockIcon)
        
        clockIcon.leftAnchor.constraint(equalTo: myScrollView.leftAnchor, constant: 20).isActive = true
        clockIcon.topAnchor.constraint(equalTo: personIcon.bottomAnchor).isActive = true
        clockIcon.widthAnchor.constraint(equalTo: myScrollView.widthAnchor, multiplier: 0.1).isActive = true
        //clockIcon.bottomAnchor.constraint(equalTo: bgView2.bottomAnchor).isActive = true
        clockIcon.heightAnchor.constraint(equalToConstant: 30).isActive = true
        clockIcon.translatesAutoresizingMaskIntoConstraints = false
        
        //SERVING SIZE AND ESTIMATED TIME INFO
        //create labels
        guard let servings = recipe.servings else { return }
        let servingSizeLabel = UILabel()
        
        servingSizeLabel.text = "\(servings) servings"
        servingSizeLabel.textColor = UIColor.white
        servingSizeLabel.font = UIFont(name: Constants.appFont.light.rawValue, size: 20)
        servingSizeLabel.textAlignment = .left
        
        let durationLabel = UILabel()
        durationLabel.textColor = UIColor.white
        durationLabel.text = "Estimated Total Time: \(totalTime) minutes"
        durationLabel.font = UIFont(name: Constants.appFont.light.rawValue, size: 20)
        
        var hours = 0
        var minutes = 0
        if totalTime % 60 == 0 {
            hours = totalTime / 60
            totalTimeString = "\(hours) hrs"
        } else if totalTime > 60 {
            hours = totalTime / 60
            minutes = totalTime - (hours * 60)
            totalTimeString = "\(hours) hrs and \(minutes) min"
        } else {
            totalTimeString = "\(totalTime) min"
        }
        
        durationLabel.font = UIFont(name: Constants.appFont.light.rawValue, size: 20)
        durationLabel.text = "\(totalTimeString)"
        durationLabel.font = UIFont(name: "GillSans-Light", size: 20)
        durationLabel.textAlignment = .left
        
        self.myScrollView.addSubview(servingSizeLabel)
        self.myScrollView.addSubview(durationLabel)
        
        // constrain labels
        servingSizeLabel.leftAnchor.constraint(equalTo: personIcon.rightAnchor, constant: 0).isActive = true
        servingSizeLabel.topAnchor.constraint(equalTo: bgView2.topAnchor).isActive = true
        servingSizeLabel.widthAnchor.constraint(equalTo: myScrollView.widthAnchor).isActive = true
        servingSizeLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        servingSizeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        durationLabel.leftAnchor.constraint(equalTo: clockIcon.rightAnchor, constant: 0).isActive = true
        durationLabel.topAnchor.constraint(equalTo: servingSizeLabel.bottomAnchor).isActive = true
        //durationLabel.bottomAnchor.constraint(equalTo: bgView2.bottomAnchor).isActive = true
        durationLabel.widthAnchor.constraint(equalTo: myScrollView.widthAnchor).isActive = true
        durationLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //INGREDIENTS LABEL
        //create label
        let ingredientsLabel = UILabel()
        ingredientsLabel.text = "Ingredients"
        ingredientsLabel.font = UIFont(name: Constants.appFont.light.rawValue, size: 25)
        ingredientsLabel.textAlignment = .center
        ingredientsLabel.textColor = UIColor.black
        
        self.myScrollView.addSubview(ingredientsLabel)
        
        //constrain label
        ingredientsLabel.backgroundColor = UIColor(red: 223/255.0, green: 218/255.0, blue: 197/255.0, alpha: 1.0)
        ingredientsLabel.leftAnchor.constraint(equalTo: myScrollView.leftAnchor, constant: 0).isActive = true
        ingredientsLabel.topAnchor.constraint(equalTo: bgView2.bottomAnchor, constant: 0).isActive = true
        ingredientsLabel.widthAnchor.constraint(equalTo: myScrollView.widthAnchor).isActive = true
        ingredientsLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //INGREDIENTS TEXT BOX
        //create textbox
        let ingredientsText = UITextView()
        ingredientsText.text = combinedIngredients
        ingredientsText.font = UIFont(name: Constants.appFont.light.rawValue, size: 20)
        ingredientsText.textAlignment = .left
        self.myScrollView.addSubview(ingredientsText)
        
        // constrain textbox
        let ingredientsContentSize = ingredientsText.sizeThatFits(ingredientsText.bounds.size)
        var ingredientsFrame = ingredientsText.frame
        ingredientsFrame.size.height = ingredientsContentSize.height
        ingredientsText.frame = ingredientsFrame
        
        ingredientsText.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor).isActive = true
        ingredientsText.widthAnchor.constraint(equalTo: myScrollView.widthAnchor, multiplier: 0.9).isActive = true
        ingredientsText.centerXAnchor.constraint(equalTo: myScrollView.centerXAnchor).isActive = true
        ingredientsText.heightAnchor.constraint(equalToConstant: ingredientsText.frame.size.height).isActive = true
        ingredientsText.translatesAutoresizingMaskIntoConstraints = false
        ingredientsText.isScrollEnabled = false
        ingredientsText.isUserInteractionEnabled = false
        
        //STEPS LABEL
        //create label
        let stepsLabel = UILabel()
        stepsLabel.text = "Steps"
        stepsLabel.font = UIFont(name: Constants.appFont.light.rawValue, size: 25)
        stepsLabel.textAlignment = .center
        stepsLabel.textColor = UIColor.white
        
        self.myScrollView.addSubview(stepsLabel)
        
        //constrain label
        stepsLabel.backgroundColor = UIColor(red: 132/255.0, green: 32/255.0, blue: 43/255.0, alpha: 1.0)
        stepsLabel.leftAnchor.constraint(equalTo: myScrollView.leftAnchor, constant: 0).isActive = true
        stepsLabel.topAnchor.constraint(equalTo: ingredientsText.bottomAnchor, constant: 0).isActive = true
        stepsLabel.widthAnchor.constraint(equalTo: myScrollView.widthAnchor).isActive = true
        stepsLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        stepsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //STEPS TEXT BOX
        //create textbox
        let stepsText = UITextView()
        stepsText.text = combinedSteps
        stepsText.font = UIFont(name: Constants.appFont.light.rawValue, size: 20)
        stepsText.textAlignment = .left
        
        self.myScrollView.addSubview(stepsText)
        
        //constrain textbox
        stepsText.centerXAnchor.constraint(equalTo: myScrollView.centerXAnchor).isActive = true
        stepsText.topAnchor.constraint(equalTo: stepsLabel.bottomAnchor).isActive = true
        stepsText.widthAnchor.constraint(equalTo: myScrollView.widthAnchor, multiplier: 0.9).isActive = true
        stepsText.bottomAnchor.constraint(equalTo: myScrollView.bottomAnchor).isActive = true
        
        stepsText.translatesAutoresizingMaskIntoConstraints = false
        stepsText.isScrollEnabled = false
        stepsText.isUserInteractionEnabled = false
    }
    
}


extension TraditionalRecipeView {
    
    func infoClick()  {
        
        let storyboard: UIStoryboard = UIStoryboard (name: "Main", bundle: nil)
        let vc: RecipePageViewController = storyboard.instantiateViewController(withIdentifier: "recipePVC") as! RecipePageViewController
        let currentController = self.getCurrentViewController()
        vc.steps = ingredientsArray
        currentController?.present(vc, animated: false, completion: nil)
        
    }
    
    func getCurrentViewController() -> UIViewController? {
        
        if let rootController = UIApplication.shared.keyWindow?.rootViewController {
            var currentController: UIViewController! = rootController
            while( currentController.presentedViewController != nil ) {
                currentController = currentController.presentedViewController
            }
            return currentController
        }
        return nil
        
    }
    
}




