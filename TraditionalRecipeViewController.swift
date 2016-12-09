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
      
        // add the select recipe button to the nav bar
        let myMenuButton = UIBarButtonItem(title: "My Menu", style: .plain, target: self, action: #selector(goToMyMenu))
        navigationItem.leftBarButtonItems = [myMenuButton]
        
        // set color and font size of nav bar buttons
        let labelFont : UIFont = UIFont(name: Constants.appFont.regular.rawValue, size: CGFloat(Constants.fontSize.xsmall.rawValue))!
        let attributesNormal = [ NSFontAttributeName : labelFont ]
        myMenuButton.setTitleTextAttributes(attributesNormal, for: .normal)

        self.traditionalRecipeView.recipe = self.recipe
        setupElements()
        checkStatus()
        
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "Recipe"
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
        backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 19).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 55).isActive = true
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.addTarget(self, action: #selector(self.backButtonTapped(sender:)), for: .touchUpInside)
        backButton.isUserInteractionEnabled = true
        
        self.view.addSubview(backButton)

        addButton = AddButton()
        self.view.addSubview(addButton)
        addButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        addButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 19).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 55).isActive = true
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.addTarget(self, action: #selector(self.buttonTapped(sender:)), for: .touchUpInside)
        
        
        removeButton = RemoveButtonView()
        self.view.addSubview(removeButton)
        removeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        removeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 19).isActive = true
        removeButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        removeButton.widthAnchor.constraint(equalToConstant: 55).isActive = true
        removeButton.translatesAutoresizingMaskIntoConstraints = false
        removeButton.addTarget(self, action: #selector(self.buttonTapped(sender:)), for: .touchUpInside)
        
        
    }
    
    func backButtonTapped(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func buttonTapped(sender: UIButton) {
        print("Calling button tapped")
        
        //*** put merge stuff and calculate time stuff here again
        store.getStepsFromRecipesSelected {
            self.store.mergedStepsArray.removeAll()
            self.store.mergeRecipeSteps()
            for step in self.store.recipeSteps {
                self.store.mergedStepsArray.append(step)
            }
        }
        print("merged step count = \(store.mergedStepsArray.count)")
        UserDefaults.standard.set(0, forKey: "stepCurrent")
        print("about to call calculate start time inside updatetableview")
        if store.mergedStepsArray.count > 0 {
            store.calculateStartTime()
            store.startCookingTimeField.text = "Start Cooking: \(store.startCookingTime)"
        }
        
        
        
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
            print("will set recipe as selected")
            print("recipe selected count before adding \(store.recipesSelected.count)")
            store.setRecipeSelected(recipe: selected)
            print("recipe selected count after adding \(store.recipesSelected.count)")
            isSelected = true
            
            UIView.animate(withDuration: 0.3, animations: {
                
                self.removeButton.alpha = 1.0
                self.addButton.alpha = 0.0
                
            })

        }
        
        delegate?.recipeSelected(recipe!, status: isSelected)
        
    }
    
    
    func goToMyMenu(){
        let myMenuViewControllerInst = MyMenuViewController()
        navigationController?.pushViewController(myMenuViewControllerInst, animated: false) // show destination with nav bar
    }

}
