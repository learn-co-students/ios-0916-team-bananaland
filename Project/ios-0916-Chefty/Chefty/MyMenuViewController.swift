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
    
    func openIngredients() {
        let ingredientsView = IngredientsController()
        navigationController?.pushViewController(ingredientsView, animated: true)
    }

}
