//
//  DataStore.swift
//  Chefty
//
//  Created by Paul Tangen on 11/17/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class DataStore {
    static let sharedInstance = DataStore()
    fileprivate init() {}
    
    var recipes:[Recipe] = []
    var recipesSelected:[Recipe] = []
    var images: [UIImage] = []
    
    var main: [Recipe] = []
    var appetizer : [Recipe] = []
    var sides : [Recipe] = []
    var desserts: [Recipe] = []
    
    var mergedStepsArray: [Step] = [] {
        didSet {
            
            
            
            
        }
    }
    var startCookingTime: String = ""
    var addedTime = 0
    
    var recipeSteps = [Step]() // can we replace this with recipe steps
    
    var earliestPossibleServeTime: Date = Date()
    
    var startCookingTimeField = UITextField() // TODO: Moving this up here after mege. Jim thinks a textField should not be stored as a property in the datastore. A viewcontroller should be in control of that, the text within the textfield can be stored in the datastore as a STring which ultimately gets displayed in a textfield on the viewcontroller.. but don't store the textfield here.
    
    
    var showNotification = false
    
    func populateHomeArrays () {
        for recipe in recipes {
            switch recipe.type! {
                
            case "main" : self.main.append(recipe)
            case "appetizer" : self.appetizer.append(recipe)
            case "side" : self.sides.append(recipe)
            case "dessert" : self.desserts.append(recipe)
            default: break
                
            }
        }
    }

    
    func getRecipesFromDB(completion: @escaping () -> ()) {
        CheftyAPIClient.getRecipiesFromDB {_ in
            completion() // call back to onViewDidLoad
        }
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Chefty") // name must match model file
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    func saveRecipesContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func getRecipesFromCoreData() {
        let context = persistentContainer.viewContext
        let recipeRequest: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        
        do {
            self.recipes = try context.fetch(recipeRequest)
        } catch let error {
            print("Error fetching data: \(error)")
        }
    }
    
    
    func updateSelectedRecipes() {
        self.recipesSelected.removeAll()
        for recipe in self.recipes {
            if recipe.selected {
                self.recipesSelected.append(recipe)
            }
        }
    }
    
    func setRecipeSelected(recipe: Recipe) {
        recipe.selected = true
        self.updateSelectedRecipes()
        self.saveRecipesContext()
        
        // rebuilding merged steps
        self.recipeSteps.removeAll()
        self.mergedStepsArray.removeAll()
        getStepsFromRecipesSelected{
            
            self.mergeRecipeSteps()
            
            for step in self.recipeSteps {
                self.mergedStepsArray.append(step)
            }
            
            self.calculateStartTime()
        }
        self.calculateStartTime()
    }
    
    func setRecipeUnselected(recipe: Recipe) {
        recipe.selected = false
        self.updateSelectedRecipes()
        
        self.saveRecipesContext()
        
        // rebuilding merged steps
        self.recipeSteps.removeAll()
        self.mergedStepsArray.removeAll()
        getStepsFromRecipesSelected{
            
            self.mergeRecipeSteps()
            
            for step in self.recipeSteps {
                self.mergedStepsArray.append(step)
            }
            self.calculateStartTime()
        }
        print("recipesSelected: \(self.recipesSelected.count)")
        print("mergedSteps: \(self.mergedStepsArray.count)")
        
        self.calculateStartTime()
    }
    
    
    //Merged Steps Set Up
    
    func getStepsFromRecipesSelected(completion: @escaping () -> ()) {
        print("1. recipe steps: \(self.recipeSteps.count)")
        self.recipeSteps.removeAll()
        print("2. recipe steps: \(self.recipeSteps.count)")
        
        for (index, singleRecipe) in self.recipesSelected.enumerated() {
            
            CheftyAPIClient.getStepsAndIngredients(recipe: singleRecipe, completion: {
                    
                    let allRecipeSteps = singleRecipe.steps!.allObjects as! [Step]
                    self.recipeSteps += allRecipeSteps
                
                if index == (self.recipesSelected.count - 1) {
                    completion()
                }
            })
        }
        
        print("3. recipe steps: \(self.recipeSteps.count)")
        
        
        print("6. recipe steps: \(self.recipeSteps.count)")
    }
    
    
    func mergeRecipeSteps() {
        print("4. recipe steps: \(self.recipeSteps.count)")
        
        self.recipeSteps = self.recipeSteps.sorted { (step1: Step, step2: Step) -> Bool in
            
            //same start
            if step1.timeToStart == step2.timeToStart {
                
                //different attentionNeeded
                if step1.fullAttentionRequired == false && step2.fullAttentionRequired == true {
                    return true
                } else if step1.fullAttentionRequired == true && step2.fullAttentionRequired == false {
                    return false
                    
                    //same attentionNeeded, add shorter duration to addedTime
                } else if step1.fullAttentionRequired == step2.fullAttentionRequired {
                    if step1.duration > step2.duration {
                        return false
                    } else if step1.duration < step2.duration {
                        return true
                    }
                }
            }
            
            //overlap duration
            if (step2.timeToStart > step1.timeToStart) && (step2.timeToStart < (step1.timeToStart + step1.duration)) {
                
                if step1.fullAttentionRequired == false && step2.fullAttentionRequired == true {
                    return true
                    
                } else if step1.fullAttentionRequired == true && step2.fullAttentionRequired == false {
                    return true
                    
                } else if step1.fullAttentionRequired == step2.fullAttentionRequired {
                    return true
                }
            }
            return step1.timeToStart < step2.timeToStart
        }
        
        print("5. recipe steps: \(self.recipeSteps.count)")
    }
    
    func calculateStartTime() {
        
        if self.recipesSelected.count != 0 && self.mergedStepsArray.count != 0 {
            
            print(" calc start recipes selected: \(self.recipesSelected.count), merged: \(self.mergedStepsArray.count)")
            
            let currentTime = Date()
            //print("Current time: \(currentTime)")
            let calendar = Calendar.current
            
            var servingTime = self.recipesSelected[0].servingTime // default or user selected serving time is same for all 4 recipes
            // print("serving time = \(servingTime)")
            
            //total cooking time = smallest timeToStart from mergedSteps + addedTime
            let totalCookingDuration = self.mergedStepsArray[0].timeToStart * -1 //+ self.addedTime
            print("cooking duration: \(totalCookingDuration)")
            //earliest possible serving time = current time + total cooking time
            self.earliestPossibleServeTime = calendar.date(byAdding: .minute, value: Int(totalCookingDuration), to: currentTime)!
            //print("earliest possible = \(self.earliestPossibleServeTime)")
            
            
            //start cooking time = serving time - total cooking duration
            let totalCookingDurationSeconds = totalCookingDuration * -60
            var startCookingTime = servingTime?.addingTimeInterval(TimeInterval(totalCookingDurationSeconds))
            
            //check that serving time is greater than earliest possible serving time
            // --> if yes, servingTime & start cooking time will work, so don't change
            if servingTime?.compare(self.earliestPossibleServeTime as Date) == ComparisonResult.orderedDescending || servingTime?.compare(self.earliestPossibleServeTime as Date) == ComparisonResult.orderedSame {
                print("case 1 start cooking time = \(startCookingTime)")
            } else {
                // --> if no, serving time = earliest possible serving time, start cooking time = earliest possible serving time - total duration
                servingTime = self.earliestPossibleServeTime as NSDate?
                
                startCookingTime = self.earliestPossibleServeTime.addingTimeInterval(TimeInterval(totalCookingDurationSeconds)) as NSDate?
                
                print("case 2 start cooking time = \(startCookingTime)")
            }
            
            let myFormatter = DateFormatter()
            myFormatter.timeStyle = .short
            if let startCookingTime = startCookingTime {
                let finalStartCookingTime = myFormatter.string(from: startCookingTime as Date)
                //print("final start cooking time: \(finalStartCookingTime)")
                self.startCookingTime = "\(finalStartCookingTime)"
                //print("start cooking time: \(startCookingTime)")
            }
            
        }
    }
    
    
    //merged steps stuff!
    
    //    var recipeSteps: [Step] = []
    //    var startCookingTimeField = UITextField()
    //
    //    func getStepsFromRecipesSelected(completion: @escaping () -> ()) {
    //        self.recipeSteps.removeAll()
    //
    //        for singleRecipe in self.recipesSelected {
    //            DispatchQueue.main.async {
    //                CheftyAPIClient.getStepsAndIngredients(recipe: singleRecipe, completion: {
    //                })
    //            }
    //            let allRecipeSteps = singleRecipe.steps!.allObjects as! [Step]
    //            self.recipeSteps += allRecipeSteps
    //        }
    //
    //        completion()
    //    }
    
    
    //    func mergeRecipeSteps() {
    //        print("starting to merge recipe steps. recipe steps count = \(self.recipeSteps.count)")
    //
    //        self.recipeSteps = self.recipeSteps.sorted { (step1: Step, step2: Step) -> Bool in
    //
    //            //same start
    //            if step1.timeToStart == step2.timeToStart {
    //
    //                //different attentionNeeded
    //                if step1.fullAttentionRequired == false && step2.fullAttentionRequired == true {
    //                    return true
    //                } else if step1.fullAttentionRequired == true && step2.fullAttentionRequired == false {
    //                    return false
    //
    //                    //same attentionNeeded, add shorter duration to addedTime
    //                } else if step1.fullAttentionRequired == step2.fullAttentionRequired {
    //                    if step1.duration > step2.duration {
    //                        return false
    //                    } else if step1.duration < step2.duration {
    //                        return true
    //                    }
    //                }
    //            }
    //
    //            //overlap duration
    //            if (step2.timeToStart > step1.timeToStart) && (step2.timeToStart < (step1.timeToStart + step1.duration)) {
    //
    //                if step1.fullAttentionRequired == false && step2.fullAttentionRequired == true {
    //                    return true
    //
    //                } else if step1.fullAttentionRequired == true && step2.fullAttentionRequired == false {
    //                    return true
    //
    //                } else if step1.fullAttentionRequired == step2.fullAttentionRequired {
    //                    return true
    //                }
    //            }
    //            return step1.timeToStart < step2.timeToStart
    //        }
    //    }
    
    
    
    func calculateExtraTime() {
        self.addedTime = 0
        
        // add extra time
        for (index, _) in self.mergedStepsArray.enumerated() {
            
            if index < self.mergedStepsArray.count - 2 {
                
                let step1 = self.mergedStepsArray[index]
                let step2 = self.mergedStepsArray[index + 1]
                
                //same start
                if step1.timeToStart == step2.timeToStart {
                    
                    //different attentionNeeded
                    if step1.fullAttentionRequired == true && step2.fullAttentionRequired == false {
                        self.addedTime += Int(step1.timeToStart) + Int(step1.duration) - Int(step2.timeToStart)
                        
                        
                        //same attentionNeeded, add shorter duration to addedTime
                    } else if step1.fullAttentionRequired == step2.fullAttentionRequired {
                        if step1.duration > step2.duration {
                            self.addedTime += Int(step2.duration)
                            
                        } else if step1.duration < step2.duration {
                            self.addedTime += Int(step1.duration)
                            
                        }
                    }
                }
                
                //overlap duration
                if (step2.timeToStart > step1.timeToStart) && (step2.timeToStart < (step1.timeToStart + step1.duration)) {
                    
                    if step1.fullAttentionRequired == false && step2.fullAttentionRequired == true {
                        self.addedTime += Int(step2.timeToStart) - (Int(step1.timeToStart) + Int(step1.duration))
                        
                        
                    } else if step1.fullAttentionRequired == true && step2.fullAttentionRequired == false {
                        self.addedTime += (Int(step1.timeToStart) + Int(step1.duration)) - Int(step2.timeToStart)
                        
                        
                    } else if step1.fullAttentionRequired == step2.fullAttentionRequired {
                        self.addedTime += (Int(step1.timeToStart) + Int(step1.duration)) - Int(step2.timeToStart)
                        
                    }
                }
            }
                
            else {
                
            }
        }
        
    }
    
}

