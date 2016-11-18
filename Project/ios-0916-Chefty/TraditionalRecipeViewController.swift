//
//  TraditionalRecipeViewController.swift
//  Chefty
//
//  Created by Jacqueline Minneman on 11/16/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

class TraditionalRecipeViewController: UIViewController {
    
    var traditionalRecipeView1: TraditionalRecipeView!
    var ingredientsTableView: UITableView  =   UITableView()
    let ingredients: [String] = ["1/2 cup flour","1/2 cup sugar","1 pound apples"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool = false) {
        self.title = "Traditional Recipe Page"
        //self.navigationController?.navigationBar.barTintColor = UIColor.blue
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView(){
        self.traditionalRecipeView1 = TraditionalRecipeView(frame: CGRect.zero)
        self.view = self.traditionalRecipeView1
    }

    
    
}
