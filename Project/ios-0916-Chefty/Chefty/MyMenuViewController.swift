//
//  MyMenuViewController.swift
//  Chefty
//
//  Created by Paul Tangen on 11/16/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

class MyMenuViewController: UIViewController, MyMenuViewDelegate {
    
    var sampleValue = String()
    var store = DataStore.sharedInstance
    let myMenuView1 = MyMenuView(frame: CGRect.zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myMenuView1.delegate = self
        self.navigationController?.setNavigationBarHidden(false, animated: .init(true))
        self.view.backgroundColor = UIColor(named: .white)
        
        // add the menu button to the nav bar
        let menuButton = UIBarButtonItem(title: "Select Recipes", style: .plain, target: self, action: #selector(goToHome))
        navigationItem.leftBarButtonItems = [menuButton]
        let menuButtonAttributes = [
            NSFontAttributeName: UIFont(name: Constants.appFont.regular.rawValue,
                                        size: CGFloat(Constants.fontSize.small.rawValue))!
        ]
        menuButton.setTitleTextAttributes(menuButtonAttributes, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool = false) {
        self.title = "My Menu"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView(){
        self.view = myMenuView1
        //myMenuView1.sampleValue = self.sampleValue
    }
    
    func goToIngredients() {
        let ingredientsView = IngredientsController()
        navigationController?.pushViewController(ingredientsView, animated: true)
    }
    
    func goToHome() {
        let homePageViewController1 = HomePageViewController()
        navigationController?.pushViewController(homePageViewController1, animated: false)
    }
    
    func goToRecipe(){
        let traditionalRecipeViewController1 = TraditionalRecipeViewController()
        //traditionalRecipeViewController1.recipe = recipe
        navigationController?.pushViewController(traditionalRecipeViewController1, animated: true) // show destination with nav bar
    }

}
