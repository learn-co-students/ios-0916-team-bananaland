//
//  WelcomeViewController.swift
//  Chefty
//
//  Created by Paul Tangen on 11/22/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController, WelcomeViewDelegate {
    
    var welcomeView1: WelcomeView!

    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeView1.delegate = self
        
        self.navigationController?.setNavigationBarHidden(true, animated: .init(true))
        self.view.backgroundColor = UIColor(named: .beige)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView(){
        self.welcomeView1 = WelcomeView(frame: CGRect.zero)
        self.view = self.welcomeView1
    }
    
    func goToHome(button: UIButton) {
        let homePageViewController1 = HomePageViewController()
        navigationController?.pushViewController(homePageViewController1, animated: true)
    }

}
