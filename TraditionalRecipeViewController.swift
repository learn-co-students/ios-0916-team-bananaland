//
//  TraditionalRecipeViewController.swift
//  Chefty
//
//  Created by Jacqueline Minneman on 11/16/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

class TraditionalRecipeViewController: UIViewController {
    
    var traditionalRecipeView: TraditionalRecipeView!
    var recipe: Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.traditionalRecipeView.recipe = self.recipe
        
        self.traditionalRecipeView.getStepsandIngredients()
        
        self.traditionalRecipeView.setUpElements()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool = false) {
        self.title = "Traditional Recipe Page"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func loadView(){
        traditionalRecipeView = TraditionalRecipeView(frame: CGRect.zero, recipe: recipe!)
        traditionalRecipeView.delegate = self
        self.view = self.traditionalRecipeView
        
    }
    
    
    
    
}

extension TraditionalRecipeViewController: TraditionalDelegate {
    
    func mergedStepsTapped(sender: TraditionalRecipeView) {
        let mergedStepsViewController = MergedStepsViewController()
        
        navigationController?.pushViewController(mergedStepsViewController, animated: true)
        print("go to merged steps pressed")
    
    }
}
