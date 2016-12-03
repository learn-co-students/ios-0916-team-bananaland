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
    var recipeSteps = [Steps]()
    var tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.view.addSubview(self.tableView)
        createConstraints()
        
        getStepsFromRecipesSelected {
            self.mergeRecipeSteps()
            
            for step in self.recipeSteps {
                self.store.mergedStepsArray.append(step)
            }
            
            self.tableView.reloadData()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool = false) {
        self.title = "Merged Recipe Steps"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeSteps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        let cell = MergedStepsTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = "\(recipeSteps[indexPath.row].timeToStart)"
        self.getImage(recipe: recipeSteps[indexPath.row].recipe!, imageView: cell.imageViewInst, view: cell)
        return cell
    }
    
    
    func createConstraints(){
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0).isActive = true
        self.tableView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1.0).isActive = true
        self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    }
    
    
    
    func getStepsFromRecipesSelected(completion: @escaping () -> ()) {
        
        self.recipeSteps.removeAll()
        
        for singleRecipe in store.recipesSelected {
            
            DispatchQueue.main.async {
                CheftyAPIClient.getStepsAndIngredients(recipeIDRequest: singleRecipe.id!, completion: {
                })
            }
            
            let allRecipeSteps = singleRecipe.step!.allObjects as! [Steps]
            
            self.recipeSteps += allRecipeSteps
            
        }
        
        completion()
        
    }
    
    func getImage(recipe: Recipe, imageView: UIImageView, view: UIView) {
        if let imageURLString = recipe.imageURLSmall {
            let imageURL: URL = URL(string: imageURLString)!
            do {
                let data = try Data(contentsOf: imageURL)
                if data.isEmpty == false {
                    imageView.image = UIImage(data: data)
                }
            } catch {
                print("error: no image")
            }
            
            view.addSubview(imageView)
            
        }
    }
    
    
}



extension MergedStepsViewController {
    
    func mergeRecipeSteps() {
        
        var addedTime = 0
        
        recipeSteps = self.recipeSteps.sorted { (step1: Steps, step2: Steps) -> Bool in
            
            //same start
            if step1.timeToStart == step2.timeToStart {
                
                //different attentionNeeded
                if step1.fullAttentionRequired == false && step2.fullAttentionRequired == true {
                    return true
                } else if step1.fullAttentionRequired == true && step2.fullAttentionRequired == false {
                    addedTime += step1.timeToStart + step1.duration - step2.timeToStart
                    //print("\(addedTime): step1 = \(step1.timeToStart); step2 = \(step2.timeToStart)")
                    return false
                    
                    //same attentionNeeded, add shorter duration to addedTime
                } else if step1.fullAttentionRequired == step2.fullAttentionRequired {
                    if step1.duration > step2.duration {
                        //TODO: addedTime += step2.duration
                        //print("\(addedTime): step1 = \(step1.timeToStart); step2 = \(step2.timeToStart)")
                        return false
                    } else if step1.duration < step2.duration {
                        //TODO: addedTime += step1.duration
                        //print("\(addedTime): step1 = \(step1.timeToStart); step2 = \(step2.timeToStart)")
                        return true
                    }
                }
            }
            
            //overlap duration
            if (step2.timeToStart > step1.timeToStart) && (step2.timeToStart < (step1.timeToStart + step1.duration)) {
                
                if step1.fullAttentionRequired == false && step2.fullAttentionRequired == true {
                    addedTime += step2.timeToStart - (step1.timeToStart + step1.duration)
                    //print("\(addedTime): step1 = \(step1.timeToStart); step2 = \(step2.timeToStart)")
                    return true
                    
                } else if step1.fullAttentionRequired == true && step2.fullAttentionRequired == false {
                    addedTime += (step1.timeToStart + step1.duration) - step2.timeToStart
                    //print("\(addedTime): step1 = \(step1.timeToStart); step2 = \(step2.timeToStart)")
                    return true
                    
                } else if step1.fullAttentionRequired == step2.fullAttentionRequired {
                    addedTime += (step1.timeToStart + step1.duration) - step2.timeToStart
                    //print("\(addedTime): step1 = \(step1.timeToStart); step2 = \(step2.timeToStart)")
                    return true
                }
            }
            
            return step1.timeToStart < step2.timeToStart
            
        }
        
    }
    
    
}

extension String {
    func convertDurationToMinutes() -> Int {
        
        let separatedNum = self.components(separatedBy: ":")
        let handleMinutesOnly = Int(separatedNum[0])
        let handleHours = Int(separatedNum[0])
        let handleMinutesWithHours = Int(separatedNum[1])
        var totalMinutes: Int = 0
        
        switch separatedNum.count {
        case 2:
            totalMinutes += handleMinutesOnly!
        case 3:
            totalMinutes += ((handleHours! * 60) + (handleMinutesWithHours!))
        default:
            print("error")
        }
        
        return totalMinutes
    }
    
    
    func convertTimeToStartToMinutes() -> Int {
        let separatedNum = self.components(separatedBy: ":")
        let handleMinutesOnly = Int(separatedNum[0])
        let handleHours = Int(separatedNum[0])
        let handleMinutesWithHours = Int(separatedNum[1])
        var totalMinutes: Int = 0
        
        switch separatedNum.count {
        case 2:
            totalMinutes += handleMinutesOnly!
        case 3:
            totalMinutes += ((handleHours! * 60) - (handleMinutesWithHours!))
        default:
            print("error")
        }
        
        return totalMinutes
    }
    
}


