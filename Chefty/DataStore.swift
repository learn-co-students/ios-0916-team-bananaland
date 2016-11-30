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

//DispatchQueue.main.async {
//
//}
//
//OperationQueue.main.addOperation {
//
//}

class DataStore {
    static let sharedInstance = DataStore()
    fileprivate init() {}
    
    var recipes:[Recipe] = []
    var recipeSteps: [RecipeStep] = []
    var recipeProceduresMerged: String = "" //this will need to be an array for tableview
    var recipesSelected:[Recipe] = []
    var images: [UIImage] = []
    
    var main: [Recipe] = []
    var appetizer : [Recipe] = []
    var sides : [Recipe] = []
    var desserts: [Recipe] = []
    
    var stepCurrent: Int = 1
    var stepTotal: Int = 12
    
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
        
        CheftyAPIClient.getRecipiesFromDB { success in
            
            
        }
        
       
    }
    
    
    func getRecipesFromDB(completion: @escaping () -> ()) {
        CheftyAPIClient.getRecipiesFromDB {_ in
            completion() // call back to onViewDidLoad
        }
    }
    
    func getRecipeSteps(completion: @escaping () -> ()) {
        
        
        CheftyAPIClient.getRecipeSteps1(with: { success in
            
            CheftyAPIClient.getRecipeSteps2(with: { success in
                
                completion()
                
                
            })
            
        })
        
        
        //
        //        CheftyAPIClient.getRecipeSteps1 {_ in
        //            print("inside Data store getting recipe steps1")
        //            completion()
        //            print("exited completion Data store getting recipe steps1")
        //
        //            CheftyAPIClient.getRecipeSteps2 {_ in
        //                print("inside Data store getting recipe steps2")
        //                completion()
        //                print("exited completion Data store getting recipe steps2")
        //            }
        //
        //        }
        
        
        
    }
    
    
    
    func fillRecipeStepsArray(completion: @escaping () -> ()) {
        
        CheftyAPIClient.getRecipiesFromDB { _ in
            
            completion()

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
    
}