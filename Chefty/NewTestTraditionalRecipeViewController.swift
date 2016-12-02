//
//  NewTestTraditionalRecipeViewController.swift
//  Chefty
//
//  Created by Arvin San Miguel on 12/1/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit


class NewTestTraditionalRecipeViewController: UIViewController {

    var backButton : BackButton!
    var addButton : AddButton!
    var recipe : Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupElements()
    }

    func setupElements() {
        
        // Back Button
        backButton = BackButton(frame: CGRect(x: 16, y: 20, width: 60, height: 60))
        backButton.addTarget(self, action: #selector(self.backButtonTapped(sender:)), for: .touchUpInside)
        backButton.isUserInteractionEnabled = true
        self.view.addSubview(backButton)
        
        // Add button
        addButton = AddButton(frame: CGRect(x: view.frame.maxX * 0.80, y: 20, width: 60, height: 60))
        self.view.addSubview(addButton)
        
    }
    
    func backButtonTapped(sender: UIButton) {
        print("pressed")
        dismiss(animated: true, completion: nil)
    }
    
    

}
