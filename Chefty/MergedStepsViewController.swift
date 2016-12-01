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
    
    var mergedStepsView: MergedStepsView!
    var store = DataStore.sharedInstance
    var recipeSteps = [RecipeStep]()
    var stepTitlesForDisplay = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAPIInfo {
            print("4")
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
    
    func getAPIInfo(with completion: @escaping () -> ()) {
        print("1")
        store.getRecipeSteps {
            print("2")
            
            for stepGroup in self.store.recipeSteps {
                self.recipeSteps.append(stepGroup)
            }
            
            print("3")
            
            completion()
            
            self.mergeRecipeSteps()
            
            print("7")
            
        }
    }

}

extension MergedStepsViewController {
    
    func mergeRecipeSteps() {
        print("5")
        
        var addedTime = 0
        
        recipeSteps = self.recipeSteps.sorted { (step1: RecipeStep, step2: RecipeStep) -> Bool in
            
            //TODO: handle optionals without force unwrapping
            
            //same start
            if step1.timeToStart == step2.timeToStart {
                
                //different attentionNeeded
                if step1.fullAttentionRequired == false && step2.fullAttentionRequired == true {
                    return true
                } else if step1.fullAttentionRequired == true && step2.fullAttentionRequired == false {
                    addedTime += step1.timeToStart! + step1.duration! - step2.timeToStart!
                    //print("\(addedTime): step1 = \(step1.timeToStart); step2 = \(step2.timeToStart)")
                    return false
                    
                    //same attentionNeeded, add shorter duration to addedTime
                } else if step1.fullAttentionRequired == step2.fullAttentionRequired {
                    if step1.duration! > step2.duration! {
                        addedTime += step2.duration!
                        //print("\(addedTime): step1 = \(step1.timeToStart); step2 = \(step2.timeToStart)")
                        return false
                    } else if step1.duration! < step2.duration! {
                        addedTime += step1.duration!
                        //print("\(addedTime): step1 = \(step1.timeToStart); step2 = \(step2.timeToStart)")
                        return true
                    }
                }
            }
            
            //overlap duration
            if (step2.timeToStart! > step1.timeToStart!) && (step2.timeToStart! < (step1.timeToStart! + step1.duration!)) {
                
                if step1.fullAttentionRequired == false && step2.fullAttentionRequired == true {
                    addedTime += step2.timeToStart! - (step1.timeToStart! + step1.duration!)
                    //print("\(addedTime): step1 = \(step1.timeToStart); step2 = \(step2.timeToStart)")
                    return true
                    
                } else if step1.fullAttentionRequired == true && step2.fullAttentionRequired == false {
                    addedTime += (step1.timeToStart! + step1.duration!) - step2.timeToStart!
                    //print("\(addedTime): step1 = \(step1.timeToStart); step2 = \(step2.timeToStart)")
                    return true
                    
                } else if step1.fullAttentionRequired == step2.fullAttentionRequired {
                    addedTime += (step1.timeToStart! + step1.duration!) - step2.timeToStart!
                    //print("\(addedTime): step1 = \(step1.timeToStart); step2 = \(step2.timeToStart)")
                    return true
                }
            }
            
            return step1.timeToStart! < step2.timeToStart!
            
            //return(step1.duration! < step2.duration!)
            
        }
        
        //TODO: create array instead of string for tableview
        
        for step in recipeSteps {
            stepTitlesForDisplay.append("\(step.timeToStart)")
        }

        store.recipeProceduresMerged = stepTitlesForDisplay.joined(separator: "\n\n")
        
        print("6")
    }
}
