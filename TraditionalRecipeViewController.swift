//
//  TraditionalRecipeViewController.swift
//  Chefty
//
//  Created by Jacqueline Minneman on 11/16/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

protocol RecipeViewDelegate : class {
    func recipeSelected(_ recipe: Recipe, status: Bool)
}


class TraditionalRecipeViewController: UIViewController {
    
    var traditionalRecipeView: TraditionalRecipeView!
    var recipe: Recipe?
    var backButton : BackButton!
    var addButton : AddButton!
    var isSelected = false
    var store = DataStore.sharedInstance
    var removeButton : RemoveButtonView!
    
    weak var delegate: RecipeViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reloadInputViews()
        self.traditionalRecipeView.recipe = self.recipe
        setupElements()
        checkStatus()
        
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func loadView(){
        
        print("self.recipe?.displayName: \(self.recipe?.displayName)")
        self.traditionalRecipeView = TraditionalRecipeView(frame: CGRect.zero, recipe: recipe!)
        self.view = self.traditionalRecipeView
        
    }
}
    
extension TraditionalRecipeViewController {
    
    func checkStatus() {
        
        if store.recipesSelected.contains(recipe!) {
            isSelected = true
            removeButton.alpha = 1.0
            addButton.alpha = 0.0
            
        } else {
            isSelected = false
            removeButton.alpha = 0.0
            addButton.alpha = 1.0
        }
        
    }
    
    func setupElements() {
        
        //Add the backButton
        backButton = BackButton()
        self.view.addSubview(backButton)
        backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.addTarget(self, action: #selector(self.backButtonTapped(sender:)), for: .touchUpInside)
        backButton.isUserInteractionEnabled = true
        
        self.view.addSubview(backButton)

        addButton = AddButton()
        self.view.addSubview(addButton)
        addButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        addButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.addTarget(self, action: #selector(self.buttonTapped(sender:)), for: .touchUpInside)
        
        
        removeButton = RemoveButtonView()
        self.view.addSubview(removeButton)
        removeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        removeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        removeButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        removeButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        removeButton.translatesAutoresizingMaskIntoConstraints = false
        removeButton.addTarget(self, action: #selector(self.buttonTapped(sender:)), for: .touchUpInside)
        
        
    }
    
    func backButtonTapped(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func buttonTapped(sender: UIButton) {
        
        guard let selected = recipe else { return }
        
        if store.recipesSelected.count >= 4 { return }
        
        if isSelected {
            
            store.setRecipeUnselected(recipe: selected)
            isSelected = false
            
            UIView.animate(withDuration: 0.3, animations: {
                
                self.removeButton.alpha = 0.0
                self.addButton.alpha = 1.0
                
            })
    
        } else {
            
            store.setRecipeSelected(recipe: selected)
            isSelected = true
            
            UIView.animate(withDuration: 0.3, animations: {
                
                self.removeButton.alpha = 1.0
                self.addButton.alpha = 0.0
                
            })

        }
        
        delegate?.recipeSelected(recipe!, status: isSelected)
        
    }

}
