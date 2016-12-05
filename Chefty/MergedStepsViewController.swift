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
    var addedTime = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createViewAndTableView()
        
        getStepsFromRecipesSelected {
            self.mergeRecipeSteps()
            
            for step in self.recipeSteps {
                self.store.mergedStepsArray.append(step)
            }
            
            self.tableView.reloadData()
        }
        
        calculateStartTime()
        
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
        let cell = MergedStepsTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        if let stepTitle = recipeSteps[indexPath.row].stepTitle {
            cell.textLabel?.text = "\(stepTitle) (\(recipeSteps[indexPath.row].timeToStart))"
        }
        self.getImage(recipe: recipeSteps[indexPath.row].recipe!, imageView: cell.imageViewInst, view: cell)
        return cell
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
        
        myView.translatesAutoresizingMaskIntoConstraints = false
        myView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0).isActive = true
        myView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        myView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        myView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        
        
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        myLabel.widthAnchor.constraint(equalTo: myView.widthAnchor, multiplier: 1.0).isActive = true
        myLabel.leftAnchor.constraint(equalTo: myView.leftAnchor).isActive = true
        myLabel.bottomAnchor.constraint(equalTo: myView.bottomAnchor).isActive = true
        myLabel.text = "Start cooking at 4:00 pm"
        myLabel.font = myLabel.font?.withSize(24)
        myLabel.textAlignment = .center
        
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0).isActive = true
        tableView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1.0).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: myView.bottomAnchor).isActive = true
        
        
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
    
    func calculateStartTime() {
        //function lives on open MyMenu
        let currentTime = Date()
        print("current time: \(currentTime)")
        let calendar = Calendar.current
        
        var servingTime = store.recipesSelected[0].servingTime // default or user selected serving time is same for all 4 recipes
        print("serving time: \(servingTime)")
        
        //total cooking time = smallest timeToStart from mergedSteps + addedTime
        var totalCookingDuration = store.mergedStepsArray[0].timeToStart + addedTime
        print("total cooking time: \(totalCookingDuration)")
        
        //earliest possible serving time = current time + total cooking time
        let earliestPossibleServeTime = calendar.date(byAdding: .minute, value: Int(totalCookingDuration), to: currentTime)
        print("earliest serve time: \(earliestPossibleServeTime)")

        
        //start cooking time = serving time - total cooking duration
        totalCookingDuration = totalCookingDuration * -60
        var startCookingTime = servingTime?.addingTimeInterval(TimeInterval(totalCookingDuration))
        print("start cooking at: \(startCookingTime)")
        
        //check that serving time is greater than earliest possible serving time
        // --> if yes, servingTime & start cooking time will work, so don't change
        if servingTime?.compare(earliestPossibleServeTime! as Date) == ComparisonResult.orderedDescending {
            print("start cooking time and serving time remains the same")
            
        } else {
        // --> if no, serving time = earliest possible serving time, start cooking time = earliest possible serving time - total duration
            servingTime = earliestPossibleServeTime as NSDate?
            print("input time error, earliest serving time possible = \(servingTime)")
//            startCookingTime = earliestPossibleServeTime - totalCookingDuration
        }

        
        
    }
    
    
}








extension MergedStepsViewController {
    
    func mergeRecipeSteps() {
        
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


