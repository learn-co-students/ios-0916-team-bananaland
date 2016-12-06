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
    var ingredientsPerRecipeSorted = [[Ingredient]]()
    var tableView = UITableView()
    var arrayOfSectionIDs = [String]()
    var arrayOfIngredientsGlobal = [[String]]()
    var arrayOfSectionLabels = [String]()
    var selectedSection = -1
    var isExpanded = false
    //var ingredientsPerRecipeSorted = [Ingredient]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for (index, recipeSelected) in store.recipesSelected.enumerated() {
            
            self.ingredientsPerRecipeSorted.append([Ingredient]())
            
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
                                self.ingredientsPerRecipeSorted[index].append(ingredient)
                            }
                                
//                            for ingredientsInRecipe in self.ingredientsPerRecipeUnsorted[index] {
//                                
//                                
//                                
//                                let ingredientsPerRecipeSorted = self.ingredientsPerRecipeUnsorted.sorted (by: {($0.step?.stepNumber)! > ($1.step?.stepNumber)!})
//                            }
                            
                            
                            
                        }
                    }
                    print("NUMBER OF STEPS WITH INGREDIENTS: \(self.ingredientsPerRecipeSorted.count)")
                }
                print("Size of ingredients per recipe: \(self.ingredientsPerRecipeSorted[index].count)")
                
                OperationQueue.main.addOperation {
                    self.tableView.reloadData()
                }
            })
        }
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "listCell")
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: "headerCell")
        
        
        self.view.addSubview(self.tableView)
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        
        //        let recognizer = UITapGestureRecognizer(target: self, action: "didTap")
        //        self.tableView.addGestureRecognizer(recognizer)
        
        //        func didTap(recognizer: UIGestureRecognizer) {
        //            if recognizer.state == UIGestureRecognizerState.ended {
        //                let tapLocation = recognizer.location(in: self.tableView)
        //                if let tappedIndexPath = tableview.indexPathForRowAtPoint(tapLocation){
        //                    if let tappedCell = self.tableview.cellForRowAtIndexPath(tappedIndexPath) {
        //                        tappedCell.
        //                    }
        //                }
        //
        //            }
        //        }
        
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
    
    
    func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedHeader))
        
        tapGesture.numberOfTapsRequired = 1
        
        view.addGestureRecognizer(tapGesture)
        view.tag = section

    }
    
    func tappedHeader(sender: UITapGestureRecognizer) {
        if isExpanded {
            selectedSection = -1
            isExpanded = false
        } else {
            selectedSection = (sender.view?.tag)!
        }
        tableView.reloadData()
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
        
        if selectedSection > -1 {
            return ingredientsPerRecipeSorted[section].count
            
           
        }
        
        return 0
            
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = IngredientsTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "listCell")
        let ingredient = ingredientsPerRecipeSorted[indexPath.section][indexPath.row]
        
        
        cell.selectionStyle = .none
        cell.textLabel?.text = ingredient.ingredientDescription
        
        if ingredient.isChecked {
            cell.checkBox.image = UIImage(named: "ic_check_box_2x")
            
        } else {
            cell.checkBox.image = UIImage(named: "ic_check_box_outline_blank_2x")
        }
        
        return cell
    }

    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

        print("did select")
        let ingredient = ingredientsPerRecipeSorted[indexPath.section][indexPath.row]
        
        if ingredient.isChecked {
            ingredient.isChecked = false
            store.saveRecipesContext()
        } else {
            ingredient.isChecked = true
            store.saveRecipesContext()
        }
        
        tableView.reloadData()
        
    }
    
    
    
    
}


