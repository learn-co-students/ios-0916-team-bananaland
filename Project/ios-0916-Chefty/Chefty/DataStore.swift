//
//  DataStore.swift
//  Chefty
//
//  Created by Paul Tangen on 11/17/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import Foundation
import CoreData

class DataStore {
    static let sharedInstance = DataStore()
    fileprivate init() {}
    
    var recipes:[Recipe] = []
    var recipeSteps: [RecipeStep] = []
    var recipesSelected:[RecipeSelected] = []
    var recipeProceduresMerged: String = "" //this will need to be an array for tableview
    
    func getRecipes(completion: @escaping () -> ()) {
        
        CheftyAPIClient.getRecipes {_ in
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
        
        CheftyAPIClient.getRecipes {_ in
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
    
    func saveRecipeSelectedContext () {
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
    
    func fetchRecipeSelected() {
        
        let context = persistentContainer.viewContext
        let recipeRequest: NSFetchRequest<RecipeSelected> = RecipeSelected.fetchRequest()
        
        do {
            self.recipesSelected = try context.fetch(recipeRequest)
        } catch let error {
            print("Error fetching data: \(error)")
        }
        
        // generate the test recipesSelected if needed
        if recipesSelected.count == 0 {
            self.addTestRecipesSelected()
        }
    }
    
    func addTestRecipesSelected(){
        // set some recipes as selected, this will happen in the previous screen soon
        for recipe in self.recipes {
            recipe.id == "apple-pie" ? addRecipeSelected(recipe: recipe) : ()
            recipe.id == "chicken-breasts" ? addRecipeSelected(recipe: recipe) : ()
            recipe.id == "black-bean-couscous-salad" ? addRecipeSelected(recipe: recipe) : ()
            recipe.id == "yummy-baked-potato-skins" ? addRecipeSelected(recipe: recipe) : ()
        }
    }
    
    func addRecipeSelected(recipe: Recipe) {
        let context = persistentContainer.viewContext
        
        // define recipesSelected
        let recipeSelected1: RecipeSelected = NSEntityDescription.insertNewObject(forEntityName: "RecipeSelected", into: context) as! RecipeSelected
        recipeSelected1.displayName = recipe.displayName
        recipeSelected1.id = recipe.id
        recipeSelected1.imageURL = recipe.imageURL
        recipeSelected1.servings = recipe.servings
        recipeSelected1.type = recipe.type
        recipeSelected1.servingTime = recipe.servingTime as NSDate?
        recipeSelected1.imageData = recipe.imageData as NSObject?
        recipeSelected1.image = recipe.image
        
        self.saveRecipeSelectedContext()
        self.fetchRecipeSelected()
    }
}
