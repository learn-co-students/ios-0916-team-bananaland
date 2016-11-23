//
//  IngredientsController.swift
//  Chefty
//
//  Created by Joanna Tzu-Hsuan Huang on 11/16/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

class IngredientsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    typealias Parts = [(name: String, ingredients: [(desc: String, isChecked: Bool)])]
    
    var ingredientsTableView = UITableView()
//    var store = DataStore.sharedInstance
    var ingredients = Parts()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("calling API")
        
        CheftyAPIClient.getIngredients { success, response in
            guard let copy = response else { return }

            print("\n\n\(copy.description)\n\n")
            self.ingredients = copy.parts
            
            OperationQueue.main.addOperation {
                print("reload data")
                self.ingredientsTableView.reloadData()
            }

            
        }
        
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
        ingredientsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "listCell")
        
        self.view.addSubview(self.ingredientsTableView)
        

        
//        for (key, value) in recipeIngredients {
//            recipeArray.append(Ingredients(name: key, ingredients: value))
//        }
        
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
        return ingredients[section].name
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
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients[section].ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        
        cell.selectionStyle = .none
        let recipe = ingredients[indexPath.section]
        let ingredient = recipe.ingredients[indexPath.row]
        cell.textLabel?.text = ingredient.desc
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        if ingredient.isChecked {
            cell.accessoryType = UITableViewCellAccessoryType.checkmark
            
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.none
        }
        
        return cell
    }
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("did select")
        var recipe = ingredients[indexPath.section]
        
        // recipe needs to update ingredients and replace?
        
        if recipe.ingredients[indexPath.row].isChecked {
            recipe.ingredients[indexPath.row].isChecked = false
        } else {
            recipe.ingredients[indexPath.row].isChecked = true
        }
        
        tableView.reloadData()
        
    }
}

