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
    var backButton : BackButton!
    var addButton : AddButton!
    var isSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.traditionalRecipeView.recipe = self.recipe
        self.traditionalRecipeView.getStepsandIngredients()
        self.traditionalRecipeView.setUpElements()
        setupElements()
    }
    
    
    override func viewWillAppear(_ animated: Bool = false) {
        self.title = "Traditional Recipe Page"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func loadView(){
        traditionalRecipeView = TraditionalRecipeView(frame: CGRect.zero, recipe: recipe!)
        self.view = self.traditionalRecipeView
        
    }
}
    
extension TraditionalRecipeViewController {
    
    func setupElements() {
        
        //Add the backButton
        backButton = BackButton(frame: CGRect(x: 16, y: 20, width: 60, height: 60))
        backButton.addTarget(self, action: #selector(self.backButtonTapped(sender:)), for: .touchUpInside)
        backButton.isUserInteractionEnabled = true
        self.view.addSubview(backButton)
        
        let frame2 = CGRect(x: 300, y: 20, width: 60, height: 60)
        addButton = AddButton(frame: frame2)
        addButton.addTarget(self, action: #selector(self.addButtonTapped(sender:)), for: .touchUpInside)
        self.view.addSubview(addButton)
        
    }
    
    func backButtonTapped(sender: UIButton) {
        print("pressed")
        dismiss(animated: true, completion: nil)
    }
    
    func addButtonTapped(sender: UIButton) {
        
        guard let recipeName = recipe?.displayName else { return }
        
        if isSelected {
            //store.setRecipeUnselected(recipe: recipe)
            isSelected = false
            print("Removed \(recipeName)")
        } else {
            //store.setRecipeSelected(recipe: recipe)
            isSelected = true
            print("Added \(recipeName)")
        }
        
    }

    
    
}
