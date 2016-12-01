//
//  CheftyMainViewController.swift
//  Chefty
//
//  Created by Arvin San Miguel on 11/30/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

class CheftyMainViewController: UIViewController {

    
    @IBOutlet weak var controller: SegmentedControl!
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var containerView: UIView!
    
    var presentingVC : UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    private func setupView() {
        setupSegmentedControl()
        updateView()
        
    }
    
    private func setupSegmentedControl() {
        
        controller.addTarget(self, action: #selector(selectionDidChange(sender:)), for: .valueChanged)
        controller.selectedIndex = 0
        presentingVC = mainDishVC
    }
    
    func selectionDidChange(sender: UIControl) {
        updateView()
    }
    
    private lazy var mainDishVC : MainDishViewController = {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var vc = storyboard.instantiateViewController(withIdentifier: "MainDishVC") as! MainDishViewController
        self.add(asChildViewController: vc)
        return vc
        
    }()
    
    private lazy var appetizerVC : AppetizerViewController = {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var vc = storyboard.instantiateViewController(withIdentifier: "AppetizerVC") as! AppetizerViewController
        self.add(asChildViewController: vc)
        return vc
        
    }()
    
    private lazy var sidesVC : SidesViewController = {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var vc = storyboard.instantiateViewController(withIdentifier: "SidesVC") as! SidesViewController
        self.add(asChildViewController: vc)
        return vc
        
    }()
    
    private lazy var dessertVC : DessertViewController = {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var vc = storyboard.instantiateViewController(withIdentifier: "DessertVC") as! DessertViewController
        self.add(asChildViewController: vc)
        return vc
        
    }()
    
    private func add(asChildViewController viewController: UIViewController) {
        
        addChildViewController(viewController)
        containerView.addSubview(viewController.view)
        viewController.view.frame = containerView.bounds
        viewController.view.backgroundColor = UIColor.clear
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParentViewController: self)
        
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        
        viewController.willMove(toParentViewController: self)
        viewController.view.removeFromSuperview()
        viewController.removeFromParentViewController()
        
    }
    
    private func updateView() {
        
        switch controller.selectedIndex {
            
        case 0 :
            
            setupRecipeView(remove: presentingVC, add: mainDishVC)
            
        case 1 :
            
            setupRecipeView(remove: presentingVC, add: appetizerVC)
            
        case 2 :
            
            setupRecipeView(remove: presentingVC, add: sidesVC)
            
        case 3 :
            
            setupRecipeView(remove: presentingVC, add: dessertVC)
            
            
        default : break
            
        }
        
    }
    
    private func setupRecipeView(remove presentingViewController: UIViewController, add newViewController: UIViewController) {
        
        add(asChildViewController: newViewController)
        animateTransition(from: presentingViewController, to: newViewController)
        remove(asChildViewController: presentingViewController)
        presentingVC = newViewController
        
    }
    
    
    private func animateTransition(from presentingViewController: UIViewController, to newViewController: UIViewController) {
        
        newViewController.view.alpha = 0.0
        UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseInOut, animations: {
            
            newViewController.view.alpha = 1.0
            presentingViewController.view.alpha = 0.0
            
        }, completion: nil)
        
    }
    
    
    
    @IBAction func cookButtonTapped(_ sender: Any) {
    
        let menuView = TestMenuViewController()
        present(menuView, animated: true, completion: nil)
    
    }
    
    
}
