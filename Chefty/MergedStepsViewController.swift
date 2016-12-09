//
//  MergedSteps.swift
//  Chefty
//
//  Created by Jacqueline Minneman on 11/28/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import Foundation
import UIKit


class MergedStepsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var store = DataStore.sharedInstance
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: .init(true))
        
        let selectRecipeButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goToSingleStep))
        navigationItem.leftBarButtonItems = [selectRecipeButton]
        
        let labelFont : UIFont = UIFont(name: Constants.appFont.regular.rawValue, size: CGFloat(Constants.fontSize.xsmall.rawValue))!
        let attributesNormal = [ NSFontAttributeName : labelFont ]
        selectRecipeButton.setTitleTextAttributes(attributesNormal, for: .normal)
        
        createViewAndTableView()
        
        tableView.reloadData()
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewWillAppear(_ animated: Bool = false) {
        self.title = "All Steps"
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.mergedStepsArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MergedStepsTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        if let stepTitle = store.mergedStepsArray[indexPath.row].stepTitle {
            cell.textLabel?.text = "\(indexPath.row + 1). \(stepTitle)"
            cell.backgroundColor = UIColor(red: 215/255, green: 210/255, blue: 185/255, alpha: 1.0)
            cell.textLabel?.font = UIFont(name: "GillSans-Light", size: 21)
            cell.selectionStyle = .none
        }
        self.getImage(recipe: store.mergedStepsArray[indexPath.row].recipe!, imageView: cell.imageViewInst, view: cell)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserDefaults.standard.set(indexPath.row + 1, forKey: "stepCurrent")
        let singleStepView = SingleStepViewController()
        navigationController?.pushViewController(singleStepView, animated: false)
    }
    
    
    func createViewAndTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(self.tableView)
        
        let myView = UIView()
        self.view.addSubview(myView)
        
        let myLabel = UILabel()
        self.view.addSubview(myLabel)
        
        myView.backgroundColor = UIColor(named: UIColor.ColorName(rawValue: UIColor.ColorName.deepPurple.rawValue)!)
        myView.translatesAutoresizingMaskIntoConstraints = false
        myView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0).isActive = true
        myView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        myView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        myView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 64).isActive = true
        
        
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        myLabel.widthAnchor.constraint(equalTo: myView.widthAnchor, multiplier: 1.0).isActive = true
        myLabel.leftAnchor.constraint(equalTo: myView.leftAnchor).isActive = true
        myLabel.bottomAnchor.constraint(equalTo: myView.bottomAnchor, constant: -25).isActive = true
        myLabel.text = "Start cooking at \(store.startCookingTime)"
        myLabel.font = UIFont(name: "GillSans-Light", size: 30)
        myLabel.textColor = UIColor(red: 255/255, green: 255/255, blue: 238/255, alpha: 1.0)
        myLabel.textAlignment = .center
        
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0).isActive = true
        tableView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1.0).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: myView.bottomAnchor).isActive = true
        
        
    }
    
    
    func getImage(recipe: Recipe, imageView: UIImageView, view: UIView) {
        if let imageURLString = recipe.imageURLSmall {
            let url = URL(string: imageURLString)
            imageView.contentMode = .scaleAspectFit
            imageView.sd_setImage(with: url!)
            view.addSubview(imageView)
        }
    }
    
    func goToSingleStep(){
        //if on last step, send back to last step
        if UserDefaults.standard.integer(forKey: "stepCurrent")-1 < 0 {
            let nextStep:Int = store.mergedStepsArray.count
            UserDefaults.standard.set(nextStep, forKey: "stepCurrent")
        }
        //else send back to current step
        let singleStepViewControllerInst = SingleStepViewController()
        navigationController?.pushViewController(singleStepViewControllerInst, animated: false)
    }
    
}


