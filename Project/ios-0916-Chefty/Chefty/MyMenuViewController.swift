//
//  MyMenuViewController.swift
//  Chefty
//
//  Created by Paul Tangen on 11/16/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

class MyMenuViewController: UIViewController {
    
    var myMenuView1: MyMenuView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool = false) {
        self.navigationController?.navigationBar.topItem?.title = "My Menu"
        self.navigationController?.navigationBar.topItem?.titleView?.backgroundColor = UIColor.blue
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView(){
        self.myMenuView1 = MyMenuView(frame: CGRect.zero)
        self.view = self.myMenuView1
    }

}
