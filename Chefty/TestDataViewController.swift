//
//  TestDataViewController.swift
//  Chefty
//
//  Created by Arvin San Miguel on 12/2/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

class TestDataViewController: UIViewController {

    var store = DataStore.sharedInstance
    
    @IBOutlet weak var testDataLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        CheftyAPIClient.getStepsAndIngredients(recipeIDRequest: "apple-pie", completion: { _ in
            
            
            for recipe in self.store.recipes {
                
                let allSteps = recipe.step?.allObjects as! [Steps]
                
                for step in allSteps {
                    
                    print("stepTitle: \(step.stepTitle!)")
                    print("stepNumber: \(step.stepNumber)")
                    print("duration: \(step.duration!)")
                    print("fullAttentionRequired: \(step.fullAttentionRequired)")
                    print("procedure: \(step.procedure!)")
                    
                    let ingredients = step.ingredient?.allObjects as! [Ingredient]
                    
                    for ingredient in ingredients {
                        print(ingredient.isChecked)
                        guard let itemDescription = ingredient.ingredientDescription else { return }
                        print(" ITEM DESCRIPTION : \(itemDescription)")
                        OperationQueue.main.addOperation {
                            self.testDataLabel.text = itemDescription
                        }
                       
                    }
                    
                    
                }
            
            
            }
            
            
        })
        
        
        
    }

}
