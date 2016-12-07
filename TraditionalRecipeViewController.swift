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
    var store = DataStore.sharedInstance
    var removeButton : RemoveButtonView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.traditionalRecipeView.recipe = self.recipe
        self.traditionalRecipeView.getStepsandIngredients()
        self.traditionalRecipeView.setUpElements()
        setupElements()
    }
    
    
    override func viewWillAppear(_ animated: Bool = false) {
//        self.title = "Recipe"
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
        
        removeButton = RemoveButtonView(frame: frame2)
        removeButton.addTarget(self, action: #selector(self.addButtonTapped(sender:)), for: .touchUpInside)
        removeButton.alpha = 0.0
        self.view.addSubview(removeButton)
        
    }
    
    func backButtonTapped(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func addButtonTapped(sender: UIButton) {
        
        guard let selected = recipe else { return }
        
        if store.recipesSelected.count >= 4 { print("NOT ADDED");return }
        
        if isSelected {
            store.setRecipeUnselected(recipe: selected)
            isSelected = false
            
            UIView.animate(withDuration: 0.3, animations: {
                
                self.removeButton.alpha = 0.0
                self.addButton.alpha = 1.0
                
            })
            
            
            print("Removed \(store.recipesSelected.count)")
        } else {
            
            store.setRecipeSelected(recipe: selected)
            isSelected = true
            
            UIView.animate(withDuration: 0.3, animations: {
                
                self.removeButton.alpha = 1.0
                self.addButton.alpha = 0.0
                
            })

            
            
            print("Added \(store.recipesSelected.count)")
        }
        
    }

}
