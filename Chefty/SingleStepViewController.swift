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

    override func viewDidLoad() {
        super.viewDidLoad()
        singleStepViewInst.delegate = self
        
        // add the menu button to the nav bar
        let menuButton = UIBarButtonItem(title: "All Steps", style: .plain, target: self, action: #selector(goToMergedSteps))
        navigationItem.rightBarButtonItems = [menuButton]
    }
    
    override func loadView(){
        self.singleStepViewInst = SingleStepView(frame: CGRect.zero)
        self.view = self.singleStepViewInst
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "My Menu"
        self.title = "Step \(store.stepCurrent) of \(store.stepTotal)"
    }
    
    func goToMergedSteps(){
        let mergedStepsViewControllerInst = MergedStepsViewController()
        navigationController?.pushViewController(mergedStepsViewControllerInst, animated: false) // show destination with nav bar
    }
    
    func goToNextStep(){
        
        if store.stepCurrent < store.stepTotal {
            store.stepCurrent += 1
            print("next step in vc, stepCurrent changed to \(store.stepCurrent)")
        
            self.loadView()
            self.viewDidLoad()
            self.viewWillAppear(false)
        } else {
            print("last step")
        }
    }
    


}
