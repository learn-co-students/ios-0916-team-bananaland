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
    var recipesSelected:[RecipeSelected] = []
    var images: [UIImage] = []
    
    var main: [Recipe] = []
    var appetizer : [Recipe] = []
    var sides : [Recipe] = []
    var desserts: [Recipe] = []
    
    func getRecipes(completion: @escaping () -> ()) {
        
        CheftyAPIClient.getRecipies {_ in
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
    }
    
    func addRecipeSelected(recipe: Recipe) {
        let context = persistentContainer.viewContext
        
        // define recipesSelected
        let recipeSelectedInst: RecipeSelected = NSEntityDescription.insertNewObject(forEntityName: "RecipeSelected", into: context) as! RecipeSelected
        recipeSelectedInst.displayName = recipe.displayName
        recipeSelectedInst.id = recipe.id
        recipeSelectedInst.imageURL = recipe.imageURL
        recipeSelectedInst.servings = recipe.servings
        recipeSelectedInst.type = recipe.type
        recipeSelectedInst.servingTime = recipe.servingTime as NSDate?
        recipeSelectedInst.sortValue = Int16(recipe.sortValue)
        
        self.saveRecipeSelectedContext()
        self.fetchRecipeSelected()
    }
}
