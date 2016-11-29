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
        self.tabBar.barTintColor = UIColor.black
        self.tabBar.frame = CGRect(x: 0.0, y: view.bounds.height * 0.18, width: view.bounds.width, height: view.bounds.height * 0.05)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.white], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.green], for: .selected)
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.reloadInputViews()
    }
}

extension RecipeTabViewController: UITabBarControllerDelegate {
    
    public func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        
        let fromView: UIView = tabBarController.selectedViewController!.view
        let toView  : UIView = viewController.view
        if fromView == toView {
            return false
        }
        
        UIView.transition(from: fromView, to: toView, duration: 0.3, options: .transitionCrossDissolve) { (finished:Bool) in
            
        }
        return true
    }
}
