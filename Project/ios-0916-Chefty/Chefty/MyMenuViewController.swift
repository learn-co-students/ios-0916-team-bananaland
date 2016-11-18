//
//  MyMenuViewController.swift
//  Chefty
//
//  Created by Paul Tangen on 11/16/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

class MyMenuViewController: UIViewController {
    
    var sampleValue = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool = false) {
        self.title = "My Menu"
        //self.navigationController?.navigationBar.barTintColor = UIColor.blue
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView(){
        let myMenuView1 = MyMenuView(frame: CGRect.zero)
        self.view = myMenuView1
        
        myMenuView1.sampleValue = self.sampleValue
        print(myMenuView1.sampleValue)
    }

}
