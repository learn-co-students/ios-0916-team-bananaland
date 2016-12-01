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
    var backButton : BackButton!
    var slideButton : SlidesButton!
    var addButton : AddButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupElements()
        
    }
    
    func slideButtonTapped(sender: UIButton!) {
        print("GO TO SLIDESHOW")
    }
    
    func backButtonTapped(sender: UIButton) {
        print("pressed")
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool = false) {
        self.title = "Test Traditional Recipe Page"
    }
    
    override func loadView() {
        self.view = TestTraditionalRecipeView(recipe: recipe!)
    }
    
    func setupElements() {
        
        //Add the backButton
        backButton = BackButton(frame: CGRect(x: 16, y: 20, width: 60, height: 60))
        backButton.addTarget(self, action: #selector(self.backButtonTapped(sender:)), for: .touchUpInside)
        backButton.isUserInteractionEnabled = true
        self.view.addSubview(backButton)
        
        //Add Instruction Slides
        let frame = CGRect(x: 0.0, y: 0.0, width: view.bounds.width * 0.7, height: view.bounds.height * 0.10)
        slideButton = SlidesButton(frame: frame)
        slideButton.center.y = view.center.y * 1.85
        slideButton.center.x = view.center.x
        slideButton.titleLabel?.text = "TEST BUTTON"
        slideButton.titleLabel?.textColor = UIColor.white
        slideButton.isUserInteractionEnabled = true
        slideButton.addTarget(self, action: #selector(self.slideButtonTapped(sender:)), for: .touchUpInside)
        self.view.addSubview(slideButton)
        
        addButton = AddButton(frame: CGRect(x: view.frame.maxX * 0.80, y: 20, width: 60, height: 60))
        self.view.addSubview(addButton)
        
    }

    
}
