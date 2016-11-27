//
//  MyMenuViewController.swift
//  Chefty
//
//  Created by Paul Tangen on 11/16/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit
import AudioToolbox
import LNRSimpleNotifications

class MyMenuViewController: UIViewController, MyMenuViewDelegate {
    
    var store = DataStore.sharedInstance
    let myMenuView1 = MyMenuView(frame: CGRect.zero)
    var sampleValue = String()
    
    let notificationManager1 = LNRNotificationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myMenuView1.delegate = self
        self.navigationController?.setNavigationBarHidden(false, animated: .init(true))
        self.view.backgroundColor = UIColor(named: .white)
       // print(Recipe.getServingTime(hours: 19, minutes: 0))
        
        // add the menu button to the nav bar
        let menuButton = UIBarButtonItem(title: "Select Recipes", style: .plain, target: self, action: #selector(goToHome))
        navigationItem.leftBarButtonItems = [menuButton]
        let menuButtonAttributes = [
            NSFontAttributeName: UIFont(name: Constants.appFont.regular.rawValue,
                                        size: CGFloat(Constants.fontSize.small.rawValue))!
        ]
        menuButton.setTitleTextAttributes(menuButtonAttributes, for: .normal)
        
        // notification
        notificationManager1.notificationsPosition = LNRNotificationPosition.top
        notificationManager1.notificationsBackgroundColor = UIColor.white
        notificationManager1.notificationsTitleTextColor = UIColor.black
        notificationManager1.notificationsBodyTextColor = UIColor.darkGray
        notificationManager1.notificationsSeperatorColor = UIColor.gray
        notificationManager1.notificationsIcon = UIImage(named: "Icon-App-72x72")
        
//        let alertSoundURL: URL? = Bundle.main.url(forResource: "click", withExtension: "wav")
//        if let _ = alertSoundURL {
//            var mySound: SystemSoundID = 0
//            AudioServicesCreateSystemSoundID(alertSoundURL! as CFURL, &mySound)
//            notificationManager1.notificationSound = mySound
//        }
        
        var notificationMessage = String()
        if store.recipesSelected.count == 1 {
            notificationMessage = "Last time you were here, you selected one recipe, lets review it."
        } else if store.recipesSelected.count > 1 {
            notificationMessage = "Last time you were here, you selected \(store.recipesSelected.count) recipes, lets review them."
        }
        
        notificationManager1.showNotification(title: "Welcome Back to Chefty", body: notificationMessage, onTap: { () -> Void in
            let _ = self.notificationManager1.dismissActiveNotification(completion: { () -> Void in
                print("Notification dismissed")
            })
        })
        
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
        traditionalRecipeViewController1.recipe = self.myMenuView1.recipeForTraditionalRecipeView
        navigationController?.pushViewController(traditionalRecipeViewController1, animated: true) // show destination with nav bar
    }

}
