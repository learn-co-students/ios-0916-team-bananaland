//
//  TestTraditionalRecipeViewController.swift
//  Chefty
//
//  Created by Arvin San Miguel on 11/23/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

class TestTraditionalRecipeViewController: UIViewController {

    var testTraditionalRecipeView: TestTraditionalRecipeView!
    var recipe: Recipe?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let back = UITapGestureRecognizer(target: self, action: #selector(self.handleSwipes(sender:)))
        back.numberOfTapsRequired = 1
        self.view.isUserInteractionEnabled = true
        view.addGestureRecognizer(back)
        
    }
    
    func handleSwipes(sender: UITapGestureRecognizer) {
        
        if sender.state == .ended {
            dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool = false) {
        self.title = "Test Traditional Recipe Page"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        self.view = TestTraditionalRecipeView(recipe: recipe!)
    }

    
}
