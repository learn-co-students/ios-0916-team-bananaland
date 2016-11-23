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
    var testView : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tabBar.frame.origin = CGPoint(x: 0.0, y: 1.0)
        self.tabBar.backgroundColor = UIColor.black
        self.tabBar.frame = CGRect(x: 0.0, y: view.bounds.height * 0.17, width: view.bounds.width, height: view.bounds.height * 0.05)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.white], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.green], for: .selected)
        
        let frame = CGRect(x: 0.0, y: 0.0, width: view.bounds.width, height: view.bounds.height * 0.25)
        testView = UIView(frame: frame)
        let black = UIColor(white: 0.0, alpha: 0.5)
        testView.backgroundColor = black
        
        view.addSubview(testView)
        view.sendSubview(toBack: testView)
        
    }
    
}
