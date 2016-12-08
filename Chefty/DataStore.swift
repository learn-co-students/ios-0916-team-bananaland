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
    
    var mergedStepsArray: [Steps] = []
    var startCookingTime: String = ""
    var addedTime = 0
    
    var earliestPossibleServeTime: Date = Date()
    
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
        self.saveRecipesContext()
        self.updateSelectedRecipes()
    }
    
    func setRecipeUnselected(recipe: Recipe) {
        recipe.selected = false
        self.saveRecipesContext()
        self.updateSelectedRecipes()
    }
    
    func calculateStartTime() {
        
        if self.mergedStepsArray.count != 0 {
            let currentTime = Date()
            let calendar = Calendar.current
            
            var servingTime = self.recipesSelected[0].servingTime // default or user selected serving time is same for all 4 recipes
            
            //total cooking time = smallest timeToStart from mergedSteps + addedTime
            let totalCookingDuration = self.mergedStepsArray[0].timeToStart * -1 + self.addedTime
            
            //earliest possible serving time = current time + total cooking time
            self.earliestPossibleServeTime = calendar.date(byAdding: .minute, value: Int(totalCookingDuration), to: currentTime)!
            
            
            //start cooking time = serving time - total cooking duration
            let totalCookingDurationSeconds = totalCookingDuration * -60
            var startCookingTime = servingTime?.addingTimeInterval(TimeInterval(totalCookingDurationSeconds))
            
            //check that serving time is greater than earliest possible serving time
            // --> if yes, servingTime & start cooking time will work, so don't change
            if servingTime?.compare(self.earliestPossibleServeTime as Date) == ComparisonResult.orderedDescending || servingTime?.compare(self.earliestPossibleServeTime as Date) == ComparisonResult.orderedSame {
                
            } else {
                // --> if no, serving time = earliest possible serving time, start cooking time = earliest possible serving time - total duration
                servingTime = self.earliestPossibleServeTime as NSDate?
               
                startCookingTime = self.earliestPossibleServeTime.addingTimeInterval(TimeInterval(totalCookingDurationSeconds)) as NSDate?
            }
                        
            let myFormatter = DateFormatter()
            myFormatter.timeStyle = .short
            if let startCookingTime = startCookingTime {
                let finalStartCookingTime = myFormatter.string(from: startCookingTime as Date)
                self.startCookingTime = "\(finalStartCookingTime)"
            }
            
        }
    }
}
