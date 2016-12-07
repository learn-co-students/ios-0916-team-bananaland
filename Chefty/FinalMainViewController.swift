//
//  FinalMainViewController.swift
//  Chefty
//
//  Created by Arvin San Miguel on 12/6/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

class FinalMainViewController: UIViewController {
    
    var containerView : UIView!
    var bgView: UIView!
    var controller: SegmentedControl!
    var presentingVC : UIViewController!
    var store = DataStore.sharedInstance
    var previousSelectedSegment = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        print(store.recipesSelected.count)
        print("viewDidLoad of final")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    private func setupView() {
        setupElements()
        setupSegmentedControl()
        updateView()
    }
    
    
    private func setupElements() {
        
        self.edgesForExtendedLayout = .bottom
        self.extendedLayoutIncludesOpaqueBars = true
        
        //Setup navigation Buttons
        let selectedRecipeIcon = CookButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        let selectedRecipeButton = UIBarButtonItem()
        selectedRecipeButton.customView = selectedRecipeIcon
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.cookButtonTapped(sender:)))
        tap.numberOfTapsRequired = 1
        selectedRecipeIcon.addGestureRecognizer(tap)
        
        navigationItem.rightBarButtonItem = selectedRecipeButton
        navigationItem.titleView = CheftyTitleView(frame: CGRect(x: 0, y: 0, width: 160, height: 50))
        navigationItem.titleView?.backgroundColor = UIColor.clear
        
        bgView = UIView()
        bgView.backgroundColor = UIColor(red: 132/255.0, green: 32/255.0, blue: 43/255.0, alpha: 1.0)
        view.addSubview(bgView)
        bgView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bgView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        bgView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        bgView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        bgView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        bgView.translatesAutoresizingMaskIntoConstraints = false
        
        controller = SegmentedControl()
        bgView.addSubview(controller)
        controller.topAnchor.constraint(equalTo: bgView.topAnchor).isActive = true
        controller.leftAnchor.constraint(equalTo: bgView.leftAnchor).isActive = true
        controller.rightAnchor.constraint(equalTo: bgView.rightAnchor).isActive = true
        controller.heightAnchor.constraint(equalToConstant: 50).isActive = true
        controller.translatesAutoresizingMaskIntoConstraints = false
        
        
        containerView = UIView()
        view.addSubview(containerView)
        containerView.topAnchor.constraint(equalTo: bgView.bottomAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func setupSegmentedControl() {
        
        controller.addTarget(self, action: #selector(selectionDidChange(sender:)), for: .valueChanged)
        controller.selectedIndex = 0
//      presentingVC = appetizerVC
//      setupRecipeView(remove: appetizerVC, add: mainDishVC)
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
            if previousSelectedSegment == controller.selectedIndex { return }
            setupRecipeView(remove: presentingVC, add: mainDishVC)
            
        case 1 :
            if previousSelectedSegment == controller.selectedIndex { return }
            setupRecipeView(remove: presentingVC, add: appetizerVC)
            
        case 2 :
            if previousSelectedSegment == controller.selectedIndex { return }
            setupRecipeView(remove: presentingVC, add: sidesVC)
            
        case 3 :
            if previousSelectedSegment == controller.selectedIndex { return }
            setupRecipeView(remove: presentingVC, add: dessertVC)
            
            
        default : break
            
        }
        
    }
    
    private func setupRecipeView(remove presentingViewController: UIViewController?, add newViewController: UIViewController) {
        
        add(asChildViewController: newViewController)
        if let presentingViewController = presentingViewController {
            animateTransition(from: presentingViewController, to: newViewController)
            remove(asChildViewController: presentingViewController)
        }
        presentingVC = newViewController
        previousSelectedSegment = controller.selectedIndex
    }
    
    
    private func animateTransition(from presentingViewController: UIViewController, to newViewController: UIViewController) {
        
        newViewController.view.alpha = 0.0
        UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseInOut, animations: {
            
            newViewController.view.alpha = 1.0
            presentingViewController.view.alpha = 0.0
            
        }, completion: nil)
        
    }
    
    func cookButtonTapped(sender: UIBarButtonItem) {
        let myMenu = MyMenuViewController()
        //navigationController?.pushViewController(myMenu, animated: true)
        navigationController?.popToRootViewController(animated: true)
    }
    
}
