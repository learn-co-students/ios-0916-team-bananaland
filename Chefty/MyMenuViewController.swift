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
    let myMenuViewInst = MyMenuView(frame: CGRect.zero)
    var sampleValue = String()
    let notificationManagerInst = LNRNotificationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("hi")
        
        myMenuViewInst.delegate = self
        self.navigationController?.setNavigationBarHidden(false, animated: .init(true))
        self.view.backgroundColor = UIColor(named: .white)
        
        // add the select recipe button to the nav bar
        let selectRecipeButton = UIBarButtonItem(title: "Select Recipes", style: .plain, target: self, action: #selector(goToHome))
        navigationItem.leftBarButtonItems = [selectRecipeButton]
  
        // set color and font size of nav bar buttons
        let labelFont : UIFont = UIFont(name: Constants.appFont.regular.rawValue, size: CGFloat(Constants.fontSize.xsmall.rawValue))!
        let attributesNormal = [ NSFontAttributeName : labelFont ]
        selectRecipeButton.setTitleTextAttributes(attributesNormal, for: .normal)

        // notification
        notificationManagerInst.notificationsPosition = LNRNotificationPosition.top
        notificationManagerInst.notificationsBackgroundColor = UIColor.white
        notificationManagerInst.notificationsTitleTextColor = UIColor.black
        notificationManagerInst.notificationsBodyTextColor = UIColor.darkGray
        notificationManagerInst.notificationsSeperatorColor = UIColor.gray
        notificationManagerInst.notificationsIcon = UIImage(named: "Icon-App-76x76")
        
        // set the notification message
        var notificationMessage = String()
        if store.recipesSelected.count == 1 {
            notificationMessage = "\nLast time you were here, you selected one recipe: let's review it!\n\n"
        } else if store.recipesSelected.count > 1 {
            notificationMessage = "\nLast time you were here, you selected \(store.recipesSelected.count) recipes: let's review them!\n\n"
        }
        
        if store.showNotification {
            notificationManagerInst.showNotification(title: "Welcome Back to Chefty", body: notificationMessage, onTap: { () -> Void in
                let _ = self.notificationManagerInst.dismissActiveNotification(completion: { () -> Void in
                    print("Notification dismissed")
                })
            })
            store.showNotification = false  // only show notification when user enters the app
        }
    }
    
    override func viewWillAppear(_ animated: Bool = false) {
        self.title = "My Menu"
        
        // adjust the button label if the step value is 0
        var stepValueForButton:Int = 1
        if UserDefaults.standard.integer(forKey: "stepCurrent") == 0 {
            stepValueForButton = 1
        } else {
            stepValueForButton = UserDefaults.standard.integer(forKey: "stepCurrent")
        }
        self.myMenuViewInst.openSingleStepButton.title = "Open Step \(stepValueForButton)"
    }

    override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning() }
    
    override func loadView(){
        self.view = myMenuViewInst
    }
    
    func goToIngredients() {
        let ingredientsView = IngredientsController()
        navigationController?.pushViewController(ingredientsView, animated: true)
    }
    
    func goToHome() {
        let finalMainViewController1 = FinalMainViewController()
        navigationController?.pushViewController(finalMainViewController1, animated: true) // show destination with nav bar
    }
    
    func goToRecipe(){ 
        let traditionalRecipeViewController1 = TraditionalRecipeViewController()
        traditionalRecipeViewController1.recipe = self.myMenuViewInst.recipeForTraditionalRecipeView
        navigationController?.pushViewController(traditionalRecipeViewController1, animated: true) // show destination with nav bar
    }
    
    func goToSingleStep(){
        // if on step 0, advance to step 1
        if UserDefaults.standard.integer(forKey: "stepCurrent") == 0 {
            UserDefaults.standard.set(1, forKey: "stepCurrent")
        }
        let singleStepViewControllerInst = SingleStepViewController()
        navigationController?.pushViewController(singleStepViewControllerInst, animated: false) // show destination with nav bar
    }
    
    func clearAllRecipes() {
        for recipeInst in store.recipesSelected {
            store.setRecipeUnselected(recipe: recipeInst)
        }
        
        myMenuViewInst.updateTableViewNow()
        myMenuViewInst.tableView.tableFooterView = UIView()  // this removes the grid lines between the rows
        
        UserDefaults.standard.set(0, forKey: "stepCurrent")
        
        // show prompt
        let message1 = "All the recipes have been removed from the menu."
        let alertController = UIAlertController(title: "", message: message1, preferredStyle: .alert)
        
        let closeAction = UIAlertAction(title: "Close My Menu", style: .default) { (_) in
            self.goToHome()
        }
        closeAction.isEnabled = true
        
        alertController.addAction(closeAction)
        self.present(alertController, animated: true) { }
        
    }
}
