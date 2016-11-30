//
//  TestMenuViewController.swift
//  Chefty
//
//  Created by Arvin San Miguel on 11/29/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit
import AudioToolbox
import LNRSimpleNotifications

class TestMenuViewController: UIViewController, MyMenuViewDelegate {
    
    var store = DataStore.sharedInstance
    let myMenuViewInst = MyMenuView(frame: CGRect.zero)
    var sampleValue = String()
    let notificationManagerInst = LNRNotificationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myMenuViewInst.delegate = self
        self.navigationController?.setNavigationBarHidden(false, animated: .init(true))
        self.view.backgroundColor = UIColor(named: .white)
        
        // add the menu button to the nav bar
        let menuButton = UIBarButtonItem(title: "Select Recipes", style: .plain, target: self, action: #selector(goToHome))
        navigationItem.leftBarButtonItems = [menuButton]
        let menuButtonAttributes = [
            NSFontAttributeName: UIFont(name: Constants.appFont.regular.rawValue,
                                        size: CGFloat(Constants.fontSize.small.rawValue))!
        ]
        menuButton.setTitleTextAttributes(menuButtonAttributes, for: .normal)
        
        // notification
        notificationManagerInst.notificationsPosition = LNRNotificationPosition.top
        notificationManagerInst.notificationsBackgroundColor = UIColor.white
        notificationManagerInst.notificationsTitleTextColor = UIColor.black
        notificationManagerInst.notificationsBodyTextColor = UIColor.darkGray
        notificationManagerInst.notificationsSeperatorColor = UIColor.gray
        notificationManagerInst.notificationsIcon = UIImage(named: "Icon-App-72x72")
        
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
        
        notificationManagerInst.showNotification(title: "Welcome Back to Chefty", body: notificationMessage, onTap: { () -> Void in
            let _ = self.notificationManagerInst.dismissActiveNotification(completion: { () -> Void in
                print("Notification dismissed")
            })
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool = false) { self.title = "My Menu" }
    
    override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning() }
    
    override func loadView(){ self.view = myMenuViewInst }
    
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
        traditionalRecipeViewController1.recipe = self.myMenuViewInst.recipeForTraditionalRecipeView
        navigationController?.pushViewController(traditionalRecipeViewController1, animated: true) // show destination with nav bar
    }
    
    func goToSingleStep(){
        let singleStepViewControllerInst = SingleStepViewController()
        navigationController?.pushViewController(singleStepViewControllerInst, animated: false) // show destination with nav bar
    }
}
