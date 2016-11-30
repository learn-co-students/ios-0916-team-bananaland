//
//  RecipeTabViewController.swift
//  Chefty
//
//  Created by Arvin San Miguel on 11/22/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

class RecipeTabViewController: UITabBarController {

    var store = DataStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.tabBar.frame.origin = CGPoint(x: 0.0, y: 1.0)
        self.tabBar.frame = CGRect(x: 0.0, y: view.bounds.height * 0.18, width: view.bounds.width, height: view.bounds.height * 0.05)
        self.tabBar.backgroundColor = UIColor.clear
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.black], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.darkGray], for: .selected)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    
    
    
}

