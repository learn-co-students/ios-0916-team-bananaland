//
//  MyMenuView.swift
//  Chefty
//
//  Created by Paul Tangen on 11/16/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

class MyMenuView: UIView {
    
    var sampleValue = String()
    var recipesSelected = [Recipe]()
    var recipeNamesTemp = String()
    var store = DataStore.sharedInstance
    
    func getImage(recipe: Recipe, imageView: UIImageView) {
        
        if recipe.imageData.length == 0 {
            let imageUrl:URL = URL(string: recipe.imageURL)!
            // Start background thread so that image loading does not make app unresponsive
            DispatchQueue.global(qos: .userInitiated).async {
                recipe.imageData = NSData(contentsOf: imageUrl)!
                // When from background thread, UI needs to be updated on main_queue
                DispatchQueue.main.async {
                    let image = UIImage(data: recipe.imageData as Data)
                    imageView.image = image
                    imageView.contentMode = UIViewContentMode.scaleAspectFit
                    self.addSubview(imageView)
                    imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 300).isActive = true
                }
            }
        } else {
            // we already have the image data so create the imageView
            let image = UIImage(data: recipe.imageData as Data)
            imageView.image = image
            imageView.contentMode = UIViewContentMode.scaleAspectFit
            self.addSubview(imageView)
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 400).isActive = true
        }
    }
    
    override init(frame:CGRect){
        super.init(frame: frame)
        
        // set some recipes as selected, this will happen in the revious screen soon
        for recipe in store.recipes {
            if recipe.id == "apple-pie"{ recipe.selected = true }
            if recipe.id == "chicken-breasts"{ recipe.selected = true }
            if recipe.id == "black-bean-couscous-salad"{ recipe.selected = true }
            if recipe.id == "yummy-baked-potato-skins"{ recipe.selected = true }
        }

        // get selected recipes
        for recipe in store.recipes {
            if recipe.selected == true {
                recipesSelected.append(recipe)
                // create the temp string
                if self.recipeNamesTemp == "" {
                    self.recipeNamesTemp = recipe.displayName
                } else {
                    self.recipeNamesTemp.append(", " + recipe.displayName)
                }
            }
        }
        
        let imageView1 = UIImageView(frame: CGRect(x:0, y:0, width:200, height:200))
        getImage(recipe: recipesSelected[0], imageView: imageView1) // gets image data and adds the imageView to the view
        imageView1.translatesAutoresizingMaskIntoConstraints = false
        
        self.backgroundColor = UIColor.white
        
        //initialize
        let deleteApp: UIButton = UIButton(type: .roundedRect)
        let selectedRecipesTextField: UITextView = UITextView()
//        let stackView = UIStackView(arrangedSubviews: buttonArray)
        
        // configure controls
        deleteApp.setTitle(Constants.iconLibrary.close.rawValue, for: .normal)
        deleteApp.titleLabel!.font =  UIFont(name: Constants.iconFont.material.rawValue, size: CGFloat(Constants.iconSize.medium.rawValue))
        deleteApp.setTitleColor(UIColor(named: .red), for: .normal)
        deleteApp.addTarget(self, action: #selector(MyMenuView.deleteAppAction), for: UIControlEvents.touchUpInside)
        
        selectedRecipesTextField.text = recipeNamesTemp
        selectedRecipesTextField.backgroundColor = UIColor.white
        print("recipeNamesTemp: \(recipeNamesTemp)")
        
        // add the button
        self.addSubview(deleteApp)
        self.addSubview(selectedRecipesTextField)
        
        // constrain the button
        deleteApp.topAnchor.constraint(equalTo: self.topAnchor, constant: 100).isActive = true
        deleteApp.translatesAutoresizingMaskIntoConstraints = false
        
        selectedRecipesTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 200).isActive = true
        selectedRecipesTextField.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        selectedRecipesTextField.heightAnchor.constraint(equalToConstant: 100).isActive = true
        selectedRecipesTextField.translatesAutoresizingMaskIntoConstraints = false

//        stackView.axis = .Horizontal
//        stackView.distribution = .FillEqually
//        stackView.alignment = .Fill
//        stackView.spacing = 5
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(stackView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func deleteAppAction() {
        print("delete app")
    }
}
