//
//  MergedSteps.swift
//  Chefty
//
//  Created by Jacqueline Minneman on 11/28/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import Foundation
import UIKit

class MergedStepsViewController: UIViewController {
    
    //TODO: add conditional to make sure recipe not already pre-loaded from ingredients
    
    var mergedStepsView: MergedStepsView!
    var store = DataStore.sharedInstance
    var recipeSteps = [Steps]()
    var stepTitlesForDisplay = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getStepsFromRecipesSelected {
            print("4")
            self.mergeRecipeSteps()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool = false) {
        self.title = "Merged Recipe Steps"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func loadView(){
        self.mergedStepsView = MergedStepsView(frame: CGRect.zero)
        self.view = self.mergedStepsView
    }
    
    
    func getStepsFromRecipesSelected(completion: @escaping () -> ()) {
        
        print("1")
        
        for singleRecipe in store.recipesSelected {
            
            DispatchQueue.main.async {
                CheftyAPIClient.getStepsAndIngredients(recipeIDRequest: singleRecipe.id!, completion: {
                    print("2")
                })
            }
            
            let allRecipeSteps = singleRecipe.step!.allObjects as! [Steps]
            self.recipeSteps += allRecipeSteps
            
        }
        
        print("3")
        
        completion()
        
        print("9")
        
    }
    
}




extension MergedStepsViewController {
    
    func mergeRecipeSteps() {
        print("5")
        
        var addedTime = 0
        
        recipeSteps = self.recipeSteps.sorted { (step1: Steps, step2: Steps) -> Bool in
            //
            //            //TODO: handle optionals without force unwrapping
            //
            //            //same start
            //            if step1.timeToStart == step2.timeToStart {
            //
            //                //different attentionNeeded
            //                if step1.fullAttentionRequired == false && step2.fullAttentionRequired == true {
            //                    return true
            //                } else if step1.fullAttentionRequired == true && step2.fullAttentionRequired == false {
            //                    addedTime += step1.timeToStart! + step1.duration! - step2.timeToStart!
            //                    //print("\(addedTime): step1 = \(step1.timeToStart); step2 = \(step2.timeToStart)")
            //                    return false
            //
            //                    //same attentionNeeded, add shorter duration to addedTime
            //                } else if step1.fullAttentionRequired == step2.fullAttentionRequired {
            //                    if step1.duration! > step2.duration! {
            //                        addedTime += step2.duration!
            //                        //print("\(addedTime): step1 = \(step1.timeToStart); step2 = \(step2.timeToStart)")
            //                        return false
            //                    } else if step1.duration! < step2.duration! {
            //                        addedTime += step1.duration!
            //                        //print("\(addedTime): step1 = \(step1.timeToStart); step2 = \(step2.timeToStart)")
            //                        return true
            //                    }
            //                }
            //            }
            //
            //            //overlap duration
            //            if (step2.timeToStart! > step1.timeToStart!) && (step2.timeToStart! < (step1.timeToStart! + step1.duration!)) {
            //
            //                if step1.fullAttentionRequired == false && step2.fullAttentionRequired == true {
            //                    addedTime += step2.timeToStart! - (step1.timeToStart! + step1.duration!)
            //                    //print("\(addedTime): step1 = \(step1.timeToStart); step2 = \(step2.timeToStart)")
            //                    return true
            //
            //                } else if step1.fullAttentionRequired == true && step2.fullAttentionRequired == false {
            //                    addedTime += (step1.timeToStart! + step1.duration!) - step2.timeToStart!
            //                    //print("\(addedTime): step1 = \(step1.timeToStart); step2 = \(step2.timeToStart)")
            //                    return true
            //
            //                } else if step1.fullAttentionRequired == step2.fullAttentionRequired {
            //                    addedTime += (step1.timeToStart! + step1.duration!) - step2.timeToStart!
            //                    //print("\(addedTime): step1 = \(step1.timeToStart); step2 = \(step2.timeToStart)")
            //                    return true
            //                }
            //            }
            //
            //            return step1.timeToStart! < step2.timeToStart!
            //
            return(step1.duration! > step2.duration!)
            
        }
        
        //TODO: create array instead of string for tableview
        
        print("6")
        for step in recipeSteps {
            stepTitlesForDisplay.append("\(step.duration)")
        }
        
        print("7")
        print("steps for display: \(stepTitlesForDisplay.joined(separator: "\n\n"))")
        store.recipeProceduresMerged = stepTitlesForDisplay.joined(separator: "\n\n")
        print("8")
        
    }
}

extension MergedStepsViewController {
    
    func convertDurationToMinutes(duration: String) -> Int {
        let separatedNum = duration.components(separatedBy: ":")
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
    
    
}
