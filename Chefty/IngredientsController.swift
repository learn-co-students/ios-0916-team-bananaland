//
//  IngredientsController.swift
//  Chefty
//
//  Created by Joanna Tzu-Hsuan Huang on 11/16/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit
import CoreData

class IngredientsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView = UITableView()
    var arrayOfSectionIDs = [String]()
    var arrayOfIngredientsGlobal = [[String]]()
    var arrayOfSectionLabels = [String]()
    
    let store = DataStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CheftyAPIClient.getStepsAndIngredients(recipeIDRequest: "apple-pie", completion:{ ingredients in
            
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
            }
            self.tableView.reloadData()
        })
        
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
    
    override func viewWillAppear(_ animated: Bool = false) {
        self.title = "Ingredients"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return store.recipesSelected.count
    }

    //TODO: GETTING WRONG RECIPE: FIXXXXXX
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return store.recipes[section].displayName
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
//            return store.recipes[section].ingredients.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        
        cell.selectionStyle = .none

//        let ingredientSet = store.recipes.ingredient! as Set
//        let ingredientsArray = Array(ingredientSet)
        
//            print(ingredientsArray)




        
               //let ingredient = ingredients[indexPath.row]
        //cell.textLabel?.text = ingredient
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        
//        if ingredient.isChecked {
//            cell.accessoryType = UITableViewCellAccessoryType.checkmark
//            
//        } else {
//            cell.accessoryType = UITableViewCellAccessoryType.none
//        }
        
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

