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
    var step: RecipeStep?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did load called")
        
        guard let recipe = recipe else { return }
        //TODO: button to access on previous page only available if recipe selected, thus no unwrapping here of optional
        
        self.traditionalRecipeView.recipe = self.recipe

        self.traditionalRecipeView.getAPIInfo {
            DispatchQueue.main.async {
                self.traditionalRecipeView.setUpElements()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool = false) {
        self.title = "Traditional Recipe Page"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func loadView(){
        self.traditionalRecipeView = TraditionalRecipeView(frame: CGRect.zero)
        self.view = self.traditionalRecipeView
    }


    
    
}
