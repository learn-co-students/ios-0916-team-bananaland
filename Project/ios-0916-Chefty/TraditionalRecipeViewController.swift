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
        print("view did load called")
        
        guard let recipe = recipe else { return }
        self.traditionalRecipeView.recipe = self.recipe

        self.traditionalRecipeView.setUpElements()
        
    }
    
    override func viewWillAppear(_ animated: Bool = false) {
        self.title = "Traditional Recipe Page"

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView(){
        self.traditionalRecipeView = TraditionalRecipeView(frame: CGRect.zero)
        self.view = self.traditionalRecipeView
    }


    
    
}
