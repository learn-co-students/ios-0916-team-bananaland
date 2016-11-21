//
//  MyMenuView.swift
//  Chefty
//
//  Created by Paul Tangen on 11/16/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

class MyMenuView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var sampleValue = String()
    var recipesSelected = [Recipe]()
    var store = DataStore.sharedInstance
    
    override init(frame:CGRect){
        super.init(frame: frame)
        
        // set some recipes as selected, this will happen in the previous screen soon
        for recipe in store.recipes {
            recipe.id == "apple-pie" ? recipe.selected = true : ()
            recipe.id == "chicken-breasts" ? recipe.selected = true : ()
            recipe.id == "black-bean-couscous-salad" ? recipe.selected = true : ()
            //recipe.id == "yummy-baked-potato-skins" ? recipe.selected = true : ()
        }

        // get selected recipes
        for recipe in store.recipes {
            recipe.selected ? recipesSelected.append(recipe) : ()
        }
        
        //initialize
        let tableView = UITableView()
        let toolbar = UIToolbar()
        
        // configure controls
        tableView.delegate = self
        tableView.dataSource = self
        
        // add the controls to the view
        self.addSubview(tableView)
        self.addSubview(toolbar)
        
        // constrain the controls
        tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 65).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 60).isActive = true
        tableView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        //toolbar.topAnchor.constraint(equalTo: self.topAnchor, constant: 65).isActive = true
        toolbar.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        toolbar.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        toolbar.translatesAutoresizingMaskIntoConstraints = false


    }
    
    func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return recipesSelected.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // set the custom cell
        let cell = MyMenuTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "prototypeCell")
        
        let cellLabelStartTime = "?"
        
        let cellLabel = "\(recipesSelected[indexPath.row].type.rawValue) @ \(cellLabelStartTime) : \(recipesSelected[indexPath.row].displayName)"
        
        cell.cellLabel1.text = cellLabel
        Recipe.getImage(recipe: recipesSelected[indexPath.row], imageView: cell.imageView1, view: cell, background: true)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // the tableview cells are divided up to always fill the page
        let rowHeight = (tableView.bounds.height)/CGFloat(self.recipesSelected.count)
        return rowHeight
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        print(recipesSelected[indexPath.row].displayName)
        //self.delegate.onPressTraditionalRecipeButton(button: traditionalRecipeButton)
        
    }
    
}
