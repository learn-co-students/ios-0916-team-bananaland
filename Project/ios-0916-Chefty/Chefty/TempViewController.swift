//
//  TempViewController.swift
//  Chefty
//
//  Created by Paul Tangen on 11/17/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

class TempViewController: UIViewController, TempViewDelegate {
    
    var tempView1: TempView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tempView1.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView(){
        self.tempView1 = TempView(frame: CGRect.zero)
        self.view = self.tempView1
    }
    
    func onPressMyMenuButton(button: UIButton) {
        let myMenuView1 = MyMenuViewController()  // create the destination
        self.present(myMenuView1, animated: true, completion: nil) // present the destination
    }

}
