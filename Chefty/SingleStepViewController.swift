//
//  SingleStepViewController.swift
//  Chefty
//
//  Created by Paul Tangen on 11/28/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

class SingleStepViewController: UIViewController {
    
    var singleStepViewInst: SingleStepView!
    let store = DataStore.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        //tempView1.delegate = self
        
//        // add the menu button to the nav bar
//        let menuButton = UIBarButtonItem(title: "All Steps", style: .plain, target: self, action: #selector(goToSingleStep))
//        navigationItem.rightBarButtonItems = [menuButton]
//        let menuButtonAttributes = [
//            NSForegroundColorAttributeName: UIColor(named: .blue),
//            NSFontAttributeName: UIFont(name: Constants.iconFont.material.rawValue,
//                                        size: CGFloat(Constants.iconSize.small.rawValue))!
//        ]
//        menuButton.setTitleTextAttributes(menuButtonAttributes, for: .normal)
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
    
    func goToSingleStep(){
        let singleStepViewControllerInst = SingleStepViewController()
        navigationController?.pushViewController(singleStepViewControllerInst, animated: false) // show destination with nav bar
    }
    


}
