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
    var ingredientsPerRecipe = [[Ingredient]]()
    var tableView = UITableView()
    var arrayOfSectionIDs = [String]()
    var arrayOfIngredientsGlobal = [[String]]()
    var arrayOfSectionLabels = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for (index, recipeSelected) in store.recipesSelected.enumerated() {
            
            self.ingredientsPerRecipe.append([Ingredient]())
            
            CheftyAPIClient.getStepsAndIngredients(recipeIDRequest: recipeSelected.id!, completion:{ ingredients in
                
                // build separate arrays of recipeSteps
                let stepsFromRecipe:[Steps] = recipeSelected.step!.allObjects as! [Steps]
                
                // looping to get array of ingredients per existence in recipe step
                for step in stepsFromRecipe {
                    
                    // getting number of ingredients per recipe step that has ingredients
                    if let stepIngredient = step.ingredient {
                        let ingredientFromStepsArray = stepIngredient.allObjects as! [Ingredient]
                        
                        if ingredientFromStepsArray.isEmpty == false {
                            for ingredient in ingredientFromStepsArray {
                                self.ingredientsPerRecipe[index].append(ingredient)
                            }
                            
                        }
                    }
                    print("NUMBER OF STEPS WITH INGREDIENTS: \(self.ingredientsPerRecipe.count)")
                }
                print("Size of ingredients per recipe: \(self.ingredientsPerRecipe[index].count)")
                
                OperationQueue.main.addOperation {
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
        return ingredientsPerRecipe[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = IngredientsTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "listCell")
        let ingredient = ingredientsPerRecipe[indexPath.section][indexPath.row]
        
        cell.selectionStyle = .none
        cell.textLabel?.text = ingredient.ingredientDescription
        cell.backgroundColor = UIColor(red: 215/255, green: 210/255, blue: 185/255, alpha: 1.0)
        
        if ingredient.isChecked {
            cell.checkBox.image = UIImage(named: "ic_check_box_2x")
            
        } else {
            cell.checkBox.image = UIImage(named: "ic_check_box_outline_blank_2x")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let ingredient = ingredientsPerRecipe[indexPath.section][indexPath.row]
        
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
