//
//  IngredientsController.swift
//  Chefty
//
//  Created by Joanna Tzu-Hsuan Huang on 11/16/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

class IngredientsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ingredientsTableView = UITableView()
    
    let store = DataStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("calling API")
        
        CheftyAPIClient.getIngredients { ingredients in
//            guard let copy = success else { return }
            //print("\n\n\(copy.description)\n\n")
            //self.ingredients = copy.
            
            OperationQueue.main.addOperation {
                print("reload data")
                //self.ingredientsList = ingredients
                self.ingredientsTableView.reloadData()
            }
            
            var setOfSectionLabels = Set<String>()
            
            for ingredient in self.store.ingredientsArray {
                print("getting IDs")
                print(self.store.recipes.count)
                for recipe in self.store.recipes {
                    print(recipe.displayName)
                    if recipe.id == ingredient.recipeID {
                        setOfSectionLabels.insert(recipe.displayName)
                        print("displayName")
                    }
                }
            }
        
            print(setOfSectionLabels)
        }
        
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
        ingredientsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "listCell")
        
        self.view.addSubview(self.ingredientsTableView)
        
        self.ingredientsTableView.translatesAutoresizingMaskIntoConstraints = false
        self.ingredientsTableView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        self.ingredientsTableView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.ingredientsTableView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.ingredientsTableView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
    }
    
    override func viewWillAppear(_ animated: Bool = false) {
        self.title = "Ingredients"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return store.ingredientsArray[section].recipeID
    }
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor(red: 0/255, green: 240/255, blue: 80/255, alpha: 1.0)
        header.textLabel?.textColor = UIColor(red: 0/255, green: 30/255, blue: 255/255, alpha: 1.0)
        header.alpha = 0.8
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.allowsMultipleSelection = true
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return store.ingredientsArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.ingredientsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        
        cell.selectionStyle = .none
        //let ingredient = store.ingredientsArray[indexPath.section].ingredients[indexPath.row]
        let recipe = store.ingredientsArray[indexPath.section].recipeID
        let ingredient = store.ingredientsArray[indexPath.row].description
        cell.textLabel?.text = ingredient
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        
//        if ingredient.isChecked {
//            cell.accessoryType = UITableViewCellAccessoryType.checkmark
//            
//        } else {
//            cell.accessoryType = UITableViewCellAccessoryType.none
//        }
//        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("did select")
        //var recipe = ingredients[indexPath.section]
//        let ingredient = ingredients.all
//        
//        if recipe.ingredients[indexPath.row].isChecked {
//            recipe.ingredients[indexPath.row].isChecked = false
//        } else {
//            recipe.ingredients[indexPath.row].isChecked = true
//        }
        
        tableView.reloadData()
        
    }
}

