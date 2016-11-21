//
//  IngredientsController.swift
//  Chefty
//
//  Created by Joanna Tzu-Hsuan Huang on 11/16/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

struct Recipe2 {
    var recipeName: String!
    var recipeIngredients: [String]!
}


class IngredientsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ingredientsTableView = UITableView()
    
    var recipeIngredients = [
        "Marinated Cheese Appetizer": ["\(8) ounces sharp cheddar cheese", "\(1)(\(8) ounce) package cream cheese", "\(1) teaspoon sugar", "\(3)⁄\(4)) teaspoon dried basil", "\(1) dash salt (to taste)", "\(1) dash black pepper (to taste)", "\(1)⁄\(2) cup olive oil", "\(1)⁄\(2) cup white wine vinegar", "\(1) (\(2) ounce) jar diced pimentos, drained", "\(3) tablespoons chopped fresh parsley", "\(3) tablespoons minced green onions", "\(3) garlic cloves, pressed"],
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
            recipeArray.append(Recipe2(recipeName: key, recipeIngredients: value))
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
    
    //    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //
    //        return label
    //    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return recipeArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeArray[section].recipeIngredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        
        let recipe = recipeArray[indexPath.section]
        let ingredients = recipe.recipeIngredients as! [String]
        cell.textLabel?.text = ingredients[indexPath.row]
        
        return cell
    }
    
    
}

