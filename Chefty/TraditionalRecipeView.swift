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
    var store = DataStore.sharedInstance
    var ingredientsArray: [String] = []
    var combinedSteps: String = ""
    var combinedIngredients: String = ""
    var totalTime: Int = 0
    

    init(frame:CGRect, recipe: Recipe){
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func getStepsandIngredients() {
        
        guard let recipe = self.recipe else { return }
        
        let recipeIDRequest = recipe.id
        
        CheftyAPIClient.getStepsAndIngredients(recipeIDRequest: recipeIDRequest!) {
        }
        
        guard let recipeStep = recipe.step else { return }
        
        let steps = recipeStep.allObjects as! [Steps]
        
        for step in steps {
            
            guard let procedure = step.procedure else { return }
            store.mergedStepsArray.append(procedure)
            
            totalTime += Int(step.duration)
            
            
            guard let stepIngredient = step.ingredient else { return }
            
            let ingredientsPerStep = stepIngredient.allObjects as! [Ingredient]
            if ingredientsPerStep.isEmpty == false {
                
                for ingredient in ingredientsPerStep {
                    guard let ingredientDescription = ingredient.ingredientDescription else { return }
                    ingredientsArray.append(ingredientDescription)
                }
                
            }
            
            
        }
        
        combinedSteps = store.mergedStepsArray.joined(separator: "\n\n")
        combinedIngredients = ingredientsArray.joined(separator: "\n")
    
    }
    
    func calculateTotalTime() {
        for step in store.mergedStepsArray {
            
        }
    }
    
    
    func setUpElements() {
        
        guard let recipe = self.recipe else { return }
        
        //SCROLLVIEW
        let myScrollView = UIScrollView()
        self.addSubview(myScrollView)
        
        myScrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        myScrollView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        myScrollView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        myScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        //IMAGE
        // create image
        let myImageView = UIImageView()
        myScrollView.addSubview(myImageView)
        
        // constrain the image
        myImageView.topAnchor.constraint(equalTo: myScrollView.topAnchor).isActive = true
        myImageView.widthAnchor.constraint(equalTo: myScrollView.widthAnchor).isActive = true

        myImageView.translatesAutoresizingMaskIntoConstraints = false
        myImageView.contentMode = .scaleAspectFit
        
        
        // grab image from URL
        let imageURL = URL(string: recipe.imageURL!)
        do {
            let data = try Data(contentsOf: imageURL!)
            if data.isEmpty == false {
                myImageView.image = UIImage(data: data)
            }
        } catch {
            print("error: no image")
        }
        
        
        //RECIPE TITLE
        //create title label
        let titleLabel = UILabel()
        titleLabel.text = recipe.displayName
        //print(recipe.displayName)
        titleLabel.font = titleLabel.font.withSize(30)
        titleLabel.textAlignment = .center
        
        myScrollView.addSubview(titleLabel)
        
        // constrain label
        titleLabel.centerXAnchor.constraint(equalTo: myScrollView.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: myImageView.bottomAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        //SERVING SIZE AND ESTIMATED TIME INFO
        //create labels
        guard let servings = recipe.servings else { return }
        let servingSizeLabel = UILabel()
        servingSizeLabel.text = "Serving Size: \(servings)"
        servingSizeLabel.font = titleLabel.font.withSize(20)
        servingSizeLabel.textAlignment = .left
        
        let durationLabel = UILabel()
        durationLabel.text = "Estimated Total Time: \(totalTime) minutes"
        durationLabel.font = titleLabel.font.withSize(20)
        durationLabel.textAlignment = .left
        
        myScrollView.addSubview(servingSizeLabel)
        myScrollView.addSubview(durationLabel)
        
        // constrain labels
        servingSizeLabel.leftAnchor.constraint(equalTo: myScrollView.leftAnchor, constant: 10).isActive = true
        servingSizeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        servingSizeLabel.widthAnchor.constraint(equalTo: myScrollView.widthAnchor).isActive = true
        servingSizeLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        servingSizeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        durationLabel.leftAnchor.constraint(equalTo: myScrollView.leftAnchor, constant: 10).isActive = true
        durationLabel.topAnchor.constraint(equalTo: servingSizeLabel.bottomAnchor).isActive = true
        durationLabel.widthAnchor.constraint(equalTo: myScrollView.widthAnchor).isActive = true
        durationLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        //INGREDIENTS LABEL
        //create label
        let ingredientsLabel = UILabel()
        ingredientsLabel.text = "Ingredients"
        ingredientsLabel.font = titleLabel.font.withSize(16)
        ingredientsLabel.textAlignment = .left
        
        myScrollView.addSubview(ingredientsLabel)
        
        //constrain label
        ingredientsLabel.leftAnchor.constraint(equalTo: myScrollView.leftAnchor, constant: 10).isActive = true
        ingredientsLabel.topAnchor.constraint(equalTo: durationLabel.bottomAnchor, constant: 10).isActive = true
        ingredientsLabel.widthAnchor.constraint(equalTo: myScrollView.widthAnchor).isActive = true
        ingredientsLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        //INGREDIENTS TEXT BOX
        //create textbox
        let ingredientsText = UITextView()
        ingredientsText.text = combinedIngredients
        ingredientsText.font = titleLabel.font.withSize(14)
        ingredientsText.textAlignment = .left
        
        myScrollView.addSubview(ingredientsText)
        
        // constrain textbox
        let ingredientsContentSize = ingredientsText.sizeThatFits(ingredientsText.bounds.size)
        var ingredientsFrame = ingredientsText.frame
        ingredientsFrame.size.height = ingredientsContentSize.height
        ingredientsText.frame = ingredientsFrame
        
        ingredientsText.leftAnchor.constraint(equalTo: myScrollView.leftAnchor, constant: 10).isActive = true
        ingredientsText.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor).isActive = true
        ingredientsText.widthAnchor.constraint(equalTo: myScrollView.widthAnchor).isActive = true
        ingredientsText.heightAnchor.constraint(equalToConstant: ingredientsText.frame.size.height).isActive = true
        ingredientsText.translatesAutoresizingMaskIntoConstraints = false
        ingredientsText.isScrollEnabled = false
        ingredientsText.isUserInteractionEnabled = false
        
        
        //STEPS LABEL
        //create label
        let stepsLabel = UILabel()
        stepsLabel.text = "Steps"
        stepsLabel.font = titleLabel.font.withSize(16)
        stepsLabel.textAlignment = .left
        
        myScrollView.addSubview(stepsLabel)
        
        //constrain label
        stepsLabel.leftAnchor.constraint(equalTo: myScrollView.leftAnchor, constant: 10).isActive = true
        stepsLabel.topAnchor.constraint(equalTo: ingredientsText.bottomAnchor, constant: 10).isActive = true
        stepsLabel.widthAnchor.constraint(equalTo: myScrollView.widthAnchor).isActive = true
        stepsLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        stepsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        //STEPS TEXT BOX
        //create textbox
        let stepsText = UITextView()
        stepsText.text = combinedSteps
        stepsText.font = titleLabel.font.withSize(14)
        stepsText.textAlignment = .left
        
        myScrollView.addSubview(stepsText)
        
        //constrain textbox
        stepsText.leftAnchor.constraint(equalTo: myScrollView.leftAnchor, constant: 10).isActive = true
        stepsText.topAnchor.constraint(equalTo: stepsLabel.bottomAnchor).isActive = true
        stepsText.bottomAnchor.constraint(equalTo: myScrollView.bottomAnchor).isActive = true
        stepsText.widthAnchor.constraint(equalTo: myScrollView.widthAnchor).isActive = true
        
        stepsText.translatesAutoresizingMaskIntoConstraints = false
        stepsText.isScrollEnabled = false
        stepsText.isUserInteractionEnabled = false
    
    }
    
}


