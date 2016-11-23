//
//  WelcomeViewController.swift
//  Chefty
//
//  Created by Paul Tangen on 11/22/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController, WelcomeViewDelegate {
    
    var welcomeView1: WelcomeView!
    let store = DataStore.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        self.welcomeView1 = WelcomeView(frame: CGRect.zero)
        self.welcomeView1.delegate = self
        
        self.navigationController?.setNavigationBarHidden(true, animated: .init(true))
        self.view.backgroundColor = UIColor(named: .white)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func loadView(){
        // load data from core data
        self.store.fetchRecipeSelected()
        store.getRecipes {
            // generate the test recipesSelected if needed
            if self.store.recipesSelected.count == 0 {
                // set some recipes as selected, this will happen in the previous screen soon
                for recipe in self.store.recipes {
                    recipe.id == "apple-pie" ? self.store.addRecipeSelected(recipe: recipe) : ()
                    recipe.id == "chicken-breasts" ? self.store.addRecipeSelected(recipe: recipe) : ()
                    recipe.id == "black-bean-couscous-salad" ? self.store.addRecipeSelected(recipe: recipe) : ()
                    recipe.id == "yummy-baked-potato-skins" ? self.store.addRecipeSelected(recipe: recipe) : ()
                }
            }}
        self.view = self.welcomeView1
    }
    
    func goToHome() {
        let homePageViewController1 = HomePageViewController()
        navigationController?.pushViewController(homePageViewController1, animated: false)
    }
    
    func goToMyMenu() {
        let myMenuViewController1 = MyMenuViewController()
        navigationController?.pushViewController(myMenuViewController1, animated: false)
    }

}
