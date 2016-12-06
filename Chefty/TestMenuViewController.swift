//
//  TestMenuViewController.swift
//  Chefty
//
//  Created by Arvin San Miguel on 11/30/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit
import Foundation
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
            notificationMessage = "\nLast time you were here, you selected one recipe, lets review it.\n\n"
        } else if store.recipesSelected.count > 1 {
            notificationMessage = "\nLast time you were here, you selected \(store.recipesSelected.count) recipes, lets review them.\n\n"
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
        self.navigationController?.setNavigationBarHidden(false, animated: .init(true))
        self.title = "My Menu"
        self.myMenuViewInst.openSingleStepButton.title = "Open Step \(self.store.stepCurrent)"
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
        let cheftyMainViewController1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "cheftyMain") as! CheftyMainViewController
        self.present(cheftyMainViewController1, animated: false, completion: nil)
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
    
    func clearAllRecipes() {
        for recipeInst in store.recipesSelected {
            store.setRecipeUnselected(recipe: recipeInst)
        }
        myMenuViewInst.tableView.reloadData()
        myMenuViewInst.tableView.tableFooterView = UIView()  // this removes the grid lines between the rows
        
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





