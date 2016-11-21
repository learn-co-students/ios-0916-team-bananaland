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

    var recipes:[Recipe] = []  // the datastore contains an array of dictionaries
    var selectedRecipes:[SelectedRecipe] = []
    
    func getRecipes(completion: @escaping () -> ()) {
        
        CheftyAPIClient.getRecipies {_ in 
            //dump(self.recipes)
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
    
    func saveContext () {
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
    
    func fetchData() {
        
        let context = persistentContainer.viewContext
        let selectedRecipeRequest: NSFetchRequest<SelectedRecipe> = SelectedRecipe.fetchRequest()
        
        do {
            self.selectedRecipes = try context.fetch(selectedRecipeRequest)
        } catch let error {
            print("Error fetching data: \(error)")
        }
    }
}
