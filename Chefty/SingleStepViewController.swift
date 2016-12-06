//
//  SingleStepViewController.swift
//  Chefty
//
//  Created by Paul Tangen on 11/28/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

class SingleStepViewController: UIViewController, SingleStepDelegate {
    
    var singleStepViewInst: SingleStepView!
    let store = DataStore.sharedInstance

    override func viewDidLoad(){
        super.viewDidLoad()
        singleStepViewInst.delegate = self
        
        // create buttons for nav bar
        let myMenuButton = UIBarButtonItem(title: "My Menu", style: .plain, target: self, action: #selector(goToMyMenu))
        let allStepsButton = UIBarButtonItem(title: "All Steps", style: .plain, target: self, action: #selector(goToMergedSteps))
        // set font size of nav bar buttons
        let labelFont: UIFont = UIFont(name: Constants.appFont.regular.rawValue, size: CGFloat(Constants.fontSize.xsmall.rawValue))!
        let attributesTextNormal = [ NSFontAttributeName : labelFont ]
        allStepsButton.setTitleTextAttributes(attributesTextNormal, for: .normal)
        myMenuButton.setTitleTextAttributes(attributesTextNormal, for: UIControlState.normal)
        // add buttons to nav bar
        navigationItem.leftBarButtonItem = myMenuButton
        navigationItem.rightBarButtonItem = allStepsButton
    }
    
    override func loadView(){
        self.singleStepViewInst = SingleStepView(frame: CGRect.zero)
        self.view = self.singleStepViewInst
    }

    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
    }

    override func viewWillAppear(_ animated: Bool){
        self.navigationController?.navigationBar.topItem?.title = "My Menu"
        self.title = "Step \(store.stepCurrent) of \(self.store.mergedStepsArray.count)"
    }
    
    func goToMyMenu(){
        let myMenuViewControllerInst = MyMenuViewController()
        navigationController?.pushViewController(myMenuViewControllerInst, animated: false) // show destination with nav bar
    }
    
    func goToMergedSteps(){
        let mergedStepsViewControllerInst = MergedStepsViewController()
        navigationController?.pushViewController(mergedStepsViewControllerInst, animated: false) // show destination with nav bar
    }
    
    func goToNextStep(){
        // the current step value has been updated before this function was called, so refresh the view to show the new step
        if store.stepCurrent <= self.store.mergedStepsArray.count{
            self.loadView()
            self.viewDidLoad()
            self.viewWillAppear(false)
            if self.store.stepCurrent == self.store.mergedStepsArray.count{
                self.store.stepCurrent = 1 // reset step position
            }
        }
    }
}
