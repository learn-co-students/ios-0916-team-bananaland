//
//  TempView.swift
//  Chefty
//
//  Created by Paul Tangen on 11/17/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

protocol TempViewDelegate: class {
    func onPressMyMenuButton(button: UIButton)
    func onPressTraditionalRecipeButton(button: UIButton)
    func onPressIngredientsButton(button: UIButton)
    func onPressHomePageButton(button: UIButton)
    func onPressWelcome(button: UIButton)
}


class TempView: UIView {
    
    weak var delegate:TempViewDelegate!

    override init(frame:CGRect){
        super.init(frame: frame)
        
        // initialize button
        let pageLabel: UILabel = UILabel()
        
        let myMenuButton: UIButton = UIButton(type: .roundedRect)
        
        let traditionalRecipeButton = UIButton(type: .roundedRect)
        
        let ingredientsButton = UIButton(type: .roundedRect)
        
        let homepageButton = UIButton(type: .roundedRect)

        let welcomeButton = UIButton(type: .roundedRect)
        
        // configure controls
        pageLabel.text = "Choose a view controller to open."
        pageLabel.font =  UIFont(name: "Helvetica", size: CGFloat(Constants.fontSize.small.rawValue))
        myMenuButton.setTitle("Open MyMenu", for: .normal)
        myMenuButton.addTarget(self, action: #selector(self.myMenuAction), for: UIControlEvents.touchUpInside)
        
        traditionalRecipeButton.setTitle("Open Traditional Recipe", for: .normal)
        traditionalRecipeButton.addTarget(self, action: #selector(self.traditionalRecipeAction), for: UIControlEvents.touchUpInside)
        
        ingredientsButton.setTitle("Open List of Ingredients", for: .normal)
        ingredientsButton.addTarget(self, action: #selector(self.goToIngredients), for: UIControlEvents.touchUpInside)
        
        homepageButton.setTitle("Homepage", for: .normal)
        homepageButton.addTarget(self, action: #selector(self.goToHomepage), for: UIControlEvents.touchUpInside)

        welcomeButton.setTitle("Welcome to Chefty", for: .normal)
        welcomeButton.addTarget(self, action: #selector(self.goToWelcome), for: UIControlEvents.touchUpInside)
        
        // add the object to the view
        self.addSubview(pageLabel)
        self.addSubview(myMenuButton)
        self.addSubview(traditionalRecipeButton)
        self.addSubview(ingredientsButton)
        self.addSubview(homepageButton)
        self.addSubview(welcomeButton)
        
        // constrain the object
        pageLabel.translatesAutoresizingMaskIntoConstraints = false
        pageLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 100).isActive = true
        pageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        myMenuButton.translatesAutoresizingMaskIntoConstraints = false
        myMenuButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 200).isActive = true
        myMenuButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 100).isActive = true
        
        traditionalRecipeButton.translatesAutoresizingMaskIntoConstraints = false
        traditionalRecipeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 250).isActive = true
        traditionalRecipeButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 100).isActive = true
        
        ingredientsButton.translatesAutoresizingMaskIntoConstraints = false
        ingredientsButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 300).isActive = true
        ingredientsButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 100).isActive = true
        
        homepageButton.translatesAutoresizingMaskIntoConstraints = false
        homepageButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 400).isActive = true
        homepageButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 100).isActive = true
        
        welcomeButton.translatesAutoresizingMaskIntoConstraints = false
        welcomeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 350).isActive = true
        welcomeButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 100).isActive = true

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func myMenuAction(myMenuButton:UIButton) {
        self.delegate.onPressMyMenuButton(button: myMenuButton)
    }
    
    func goToIngredients(ingredientsButton: UIButton) {
        self.delegate.onPressIngredientsButton(button: ingredientsButton)
    }
    
    func traditionalRecipeAction(traditionalRecipeButton:UIButton) {
        self.delegate.onPressTraditionalRecipeButton(button: traditionalRecipeButton)
    }
    
    func goToWelcome(welcomeButton:UIButton) {
        self.delegate.onPressWelcome(button: welcomeButton)
    }

    func goToHomepage(homepageButton: UIButton) {
        self.delegate.onPressHomePageButton(button: homepageButton)
    }
    
}
