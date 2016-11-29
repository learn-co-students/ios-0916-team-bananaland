//
//  IngredientsController.swift
//  Chefty
//
//  Created by Joanna Tzu-Hsuan Huang on 11/16/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit


class Recipe2 {
    var recipeName: String!
//    var recipeIngredients: [String]!
    var recipeIngredients = [(String, Bool)]()
    
    init(name: String, ingredients: [String]) {
        self.recipeName = name
        for ingredient in ingredients {
            
            self.recipeIngredients.append((ingredient, false))
        }
    }
}


class IngredientsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ingredientsTableView = UITableView()
    
    var recipeIngredients = [
        "Marinated Cheese Appetizer": ["8 ounces sharp cheddar cheese", "\(1)(\(8) ounce) package cream cheese", "\(1) teaspoon sugar", "\(3)⁄\(4)) teaspoon dried basil", "\(1) dash salt (to taste)", "\(1) dash black pepper (to taste)", "\(1)⁄\(2) cup olive oil", "\(1)⁄\(2) cup white wine vinegar", "\(1) (\(2) ounce) jar diced pimentos, drained", "\(3) tablespoons chopped fresh parsley", "\(3) tablespoons minced green onions", "\(3) garlic cloves, pressed"],
        "Sweet Potatoes": ["Olive oil", "\(5) sweet potatoes, peeled and sliced into \(1)/\(4)-inch long slices, then \(1)/\(4)-wide inch strips, using a crinkle cut knife."],
        "Grilled Morrocan Chicken": ["\(4) boneless skinless chicken breasts", "\(1)⁄\(2) cup extra virgin olive oil", "\(1)⁄\(4) cup chopped scallion", "\(1)⁄\(4) cup chopped parsley", "\(1)⁄\(4) cup chopped fresh cilantro", "\(1) tablespoon minced garlic", "\(2) teaspoons paprika", "\(2) teaspoons ground cumin", "\(1) teaspoon salt", "\(1)⁄\(4) teaspoon turmeric", "\(1)⁄\(4) teaspoon cayenne pepper"
        ]
    ]
    
    
    var recipeArray = [Recipe2]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
        ingredientsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "listCell")
        
        self.view.addSubview(self.ingredientsTableView)
        
        for (key, value) in recipeIngredients {
            recipeArray.append(Recipe2(name: key, ingredients: value))
        }
        
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
        return recipeArray[section].recipeName
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
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return recipeArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeArray[section].recipeIngredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        
        cell.selectionStyle = .none
        let recipe = recipeArray[indexPath.section]
        let ingredient = recipe.recipeIngredients[indexPath.row]
        
        cell.textLabel?.text = ingredient.0
        if ingredient.1 {
            cell.accessoryType = UITableViewCellAccessoryType.checkmark

        } else {
            cell.accessoryType = UITableViewCellAccessoryType.none

        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 //       tableView.deselectRow(at: indexPath, animated: true)
        
        print("\n\ndid select row at index path\n\n")
        
        let recipe = recipeArray[indexPath.section]
        
        
        if recipe.recipeIngredients[indexPath.row].1 {
            
            recipe.recipeIngredients[indexPath.row].1 = false

        } else {
            
            recipe.recipeIngredients[indexPath.row].1 = true

        }
        
    
        tableView.reloadData()

//        if !isChecked {
//            cell?.accessoryType = UITableViewCellAccessoryType.checkmark
//            ingredient.1 = true
//            print("checked ingredient")
//        } else {
//            cell?.accessoryType = UITableViewCellAccessoryType.none
//            ingredient.1 = false
//            print("unchecked ingredient")
//        }
    }
    
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        
//        print("\n\ndid DEselect row at index path\n\n")
//        
//        let deselectedCell = tableView.cellForRow(at: indexPath)!
//        let recipe = recipeArray[indexPath.section]
//        let ingredient = recipe.recipeIngredients[indexPath.row]
//        var isChecked = ingredient.1
//
//        deselectedCell.accessoryType = UITableViewCellAccessoryType.none
//        isChecked = false
//
//    }
//    
}

