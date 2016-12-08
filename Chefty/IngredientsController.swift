//
//  IngredientsController.swift
//  Chefty
//
//  Created by Joanna Tzu-Hsuan Huang on 11/16/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit
import CoreData

class IngredientsController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let store = DataStore.sharedInstance
    var ingredientsPerRecipe = [String: [Ingredient]]()
    var tableView = UITableView()
    var arrayOfSectionIDs = [String]()
    var arrayOfIngredientsGlobal = [[String]]()
    var arrayOfSectionLabels = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add the select recipe button to the nav bar
        let myMenuButton = UIBarButtonItem(title: "My Menu", style: .plain, target: self, action: #selector(goToMyMenu))
        navigationItem.leftBarButtonItems = [myMenuButton]
        
        // set color and font size of nav bar buttons
        let labelFont : UIFont = UIFont(name: Constants.appFont.regular.rawValue, size: CGFloat(Constants.fontSize.xsmall.rawValue))!
        let attributesNormal = [ NSFontAttributeName : labelFont ]
        myMenuButton.setTitleTextAttributes(attributesNormal, for: .normal)
        
        for recipeSelected in store.recipesSelected {
            
            CheftyAPIClient.getStepsAndIngredients(recipe: recipeSelected, completion:{ ingredients in
                
                // build separate arrays of recipeSteps
                let stepsFromRecipe:[Step] = recipeSelected.steps!.allObjects as! [Step]
                
                for step in stepsFromRecipe {
                    
                    if let ingredients = step.ingredients {
                        
                        let ingredientsFromSteps = ingredients.allObjects as! [Ingredient]
                        
                        if let recipeName = recipeSelected.displayName {
                            
                            if self.ingredientsPerRecipe.keys.contains(recipeName) {
                                
                                self.ingredientsPerRecipe[recipeName]!.append(contentsOf: ingredientsFromSteps)
                                
                            } else {
                                
                                self.ingredientsPerRecipe.updateValue(ingredientsFromSteps, forKey: recipeName)
            
                            }
                            
                            dump(self.ingredientsPerRecipe)

                        }
                        
                    } else {
                        
                        print("NO STEP!")
                        
                    }
                    
                }
                
                
                DispatchQueue.main.async {
                    
                    self.tableView.reloadData()
                    
                    
                }
                
            })
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "listCell")
        
        self.view.addSubview(self.tableView)
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
    }
    
    func goToMyMenu(){
        let myMenuViewControllerInst = MyMenuViewController()
        navigationController?.pushViewController(myMenuViewControllerInst, animated: false) // show destination with nav bar
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Ingredients"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return store.recipesSelected.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return store.recipesSelected[section].displayName
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor(named: UIColor.ColorName(rawValue: UIColor.ColorName.deepPurple.rawValue)!)
        header.textLabel?.textColor = UIColor(red: 255/255, green: 255/255, blue: 238/255, alpha: 1.0)
        header.textLabel?.font = UIFont(name: "GillSans-Light", size: 24)
        header.alpha = 0.8
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.allowsMultipleSelection = true
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.sizeToFit()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let recipe = store.recipesSelected[section].displayName else { return 0 }
        guard let ingredients = ingredientsPerRecipe[recipe] else { return 0 }
        
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = IngredientsTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "listCell")
        
        guard let recipe = store.recipesSelected[indexPath.section].displayName else { return cell }
        guard let ingredients = ingredientsPerRecipe[recipe] else { return cell }
        let ingredient = ingredients[indexPath.row]
        let ingredientName = ingredient.ingredientDescription
        
        cell.selectionStyle = .none
        cell.textLabel?.text = ingredientName
        cell.textLabel?.font = UIFont(name: "GillSans-Light", size: 16.5)
        cell.backgroundColor = UIColor(red: 215/255, green: 210/255, blue: 185/255, alpha: 1.0)
        
        if ingredient.isChecked {
            cell.checkBox.image = UIImage(named: "ic_check_box_2x")
            
        } else {
            cell.checkBox.image = UIImage(named: "ic_check_box_outline_blank_2x")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let recipe = store.recipesSelected[indexPath.section].displayName else { return }
        guard let ingredients = ingredientsPerRecipe[recipe] else { return }
        let ingredient = ingredients[indexPath.row]
        
        if ingredient.isChecked {
            ingredient.isChecked = false
            store.saveRecipesContext()
            print("un-checked item")
        } else {
            ingredient.isChecked = true
            store.saveRecipesContext()
            print("checked item")
        }
        
        tableView.reloadData()
        
    }
    
}
