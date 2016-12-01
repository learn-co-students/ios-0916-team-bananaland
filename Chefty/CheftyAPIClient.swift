//
//  CheftyAPIClient.swift
//  Chefty
//
//  Created by Paul Tangen on 11/17/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import Foundation
import UIKit
import CoreData



class CheftyAPIClient {
    
    class func getRecipiesFromDB(completion: @escaping () -> Void) {
        let store = DataStore.sharedInstance
        let urlString = "\(Secrets.cheftyAPIURL)/getRecipes.php?key=\(Secrets.cheftyKey)"
        let url = URL(string: urlString)
        
        if let unwrappedUrl = url{
            let session = URLSession.shared
            let task = session.dataTask(with: unwrappedUrl) { (data, response, error) in
                if let unwrappedData = data {
                    do {
                        let responseJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: []) as! [[String: String]]
                        
                        for recipeDict in responseJSON {
                            let context = store.persistentContainer.viewContext
                            let recipeInst = NSEntityDescription.insertNewObject(forEntityName: "Recipe", into: context) as! Recipe
                            
                            if let unwrappedDisplayName = recipeDict["displayName"] {
                                recipeInst.displayName =  unwrappedDisplayName as String
                            }
                            
                            if let unwrappedRecipeID = recipeDict["id"] {
                                recipeInst.id = unwrappedRecipeID as String
                            }
                            
                            if let unwrappedImageURL = recipeDict["imageURL"] {
                                recipeInst.imageURL = unwrappedImageURL as String
                            }
                            
                            if let unwrappedServings = recipeDict["servings"] {
                                recipeInst.servings = unwrappedServings as String
                            }
                            
                            if let unwrappedRecipeType = recipeDict["type"] {
                                recipeInst.type = unwrappedRecipeType as String
                            }
                            
                            recipeInst.servingTime = self.getServingTime() as NSDate?
                            
                            if let unwrappedSortValue = recipeDict["sortValue"] {
                                let sortValueString = unwrappedSortValue as String
                                recipeInst.sortValue = Int16(sortValueString)!
                            }
                            
                            
                            if recipeInst.id == "apple-pie" || recipeInst.id == "yummy-baked-potato-skins" || recipeInst.id == "chicken-breasts" || recipeInst.id == "black-bean-couscous-salad" {
                                recipeInst.selected = true as Bool
                            } else {
                                recipeInst.selected = false as Bool
                            }
                            
                            store.recipes.append(recipeInst)
                            
                            store.saveRecipesContext()
                            store.getRecipesFromCoreData()
                            print("getRecipesFromCoreData in CheftyAPIClient")
                        }
                        completion()
                        
                    } catch {
                        print("An error occured when creating responseJSON")
                    }
                }
            }
            task.resume()
        }
    }
    
    class func getServingTime () -> Date {
        let calendarInst = Calendar(identifier: .gregorian)
        var componentsServingTime = DateComponents()
        componentsServingTime.year = calendarInst.component(.year, from: Date())
        componentsServingTime.month = calendarInst.component(.month, from: Date())
        componentsServingTime.day = calendarInst.component(.day, from: Date())
        componentsServingTime.hour = 19
        componentsServingTime.minute = 00
        componentsServingTime.second = 00
        let servingTime = calendarInst.date(from: componentsServingTime)!
        return servingTime
    }
    
    
    //    class func getIngredients(completion: @escaping () -> Void){
    //
    //        let store = DataStore.sharedInstance
    //        let urlString = "\(Secrets.cheftyAPIURL)/getIngredients.php?key=\(Secrets.cheftyKey)&recipe1=chicken-breasts&recipe2=sweet-potato-fries&recipe3=peach-cobbler&recipe4=beef-broccoli-stir-fry"
    //
    //        guard let url = URL(string: urlString) else { return }
    //
    //        let session = URLSession.shared
    //
    //        let task = session.dataTask(with: url) { (data, response, error) in
    //            if let unwrappedData = data {
    //                do {
    //                    let responseJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: []) as! [[String: String]]
    //
    //                    for ingredientDict in responseJSON {
    //                        let context = store.persistentContainer.viewContext
    //                        let ingredientInst = Ingredient(context: context)
    //                        ingredientInst.recipeID = ingredientDict["recipeID"] as String!
    //                        print(ingredientInst.recipeID!)
    //                        ingredientInst.recipeDescription = ingredientDict["description"] as String!
    //                        print(ingredientInst.recipeDescription!)
    //                        ingredientInst.isChecked = false
    //
    //
    //                        for recipe in store.recipes {
    //                            if recipe.id == ingredientInst.recipeID {
    //                                //                                recipe.addToIngredient(ingredientInst)
    //                            }
    //                        }
    //
    //
    //
    //                        store.saveRecipesContext()
    //                    }
    //                    completion()
    //                } catch {
    //                    print("An error occured when creating responseJSON")
    //                }
    //            }
    //        }
    //        task.resume()
    //
    //
    //    }
    
    
    class func getStepsAndIngredients(recipeIDRequest: String, completion: @escaping () -> Void){
        let store = DataStore.sharedInstance
        let urlString = "\(Secrets.cheftyAPIURL)/getRecipeSteps.php?key=\(Secrets.cheftyKey)&recipe=\(recipeIDRequest)"
        let url = URL(string: urlString)
        var recipeRequested:Recipe?
        
        let context = store.persistentContainer.viewContext
        
        // get the recipe with the id that was requested
        for recipe in store.recipes {
            if recipeIDRequest == recipe.id {
                recipeRequested = recipe
            }
        }
        
        
        
//        let recipeCount = recipeRequested?.step?.allObjects.count
//        
//        
//        if recipeCount == 0 {
//            print("then im empty do something")
        
            if let unwrappedUrl = url{
                let session = URLSession.shared
                let task = session.dataTask(with: unwrappedUrl) { (data, response, error) in
                    if let unwrappedData = data {
                        do {
                            let responseJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: []) as! [[String: Any]]
                            //print(responseJSON)
                            for stepsDict in responseJSON {
                                let recipeIdFromStep = stepsDict["recipe"] as! String
                                
                                // if the step is related to the recipeRequested, get the steps and add them to the recipe in CD
                                if recipeRequested?.id == recipeIdFromStep {
                                    
                                    let newStep: Steps = Steps(context: context)
                                    
                                    // getting STEP TITLES
                                    newStep.stepTitle = stepsDict["stepTitle"] as? String
                                    //print(newStep.stepTitle)
                                    
                                    
                                    let responseJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: []) as! [[String: Any]]
                                    //print(responseJSON)
                                    
                                    for stepsDict in responseJSON {
                                        let recipeIdFromStep = stepsDict["recipe"] as! String
                                        // if the step is related to the recipeRequested, get the steps and add them to the recipe in CD
                                        if recipeRequested?.id == recipeIdFromStep {
                                            
                                            let newStep: Steps = Steps(context: context)
                                            newStep.stepTitle = stepsDict["stepTitle"] as? String   // getting STEP TITLES
                                            newStep.procedure = stepsDict["procedure"] as? String   // getting STEP PROCEDURE
                                            newStep.fullAttentionRequired = Bool(stepsDict["fullAttentionRequired"] as! String)!  // getting FULL ATTENTION
                                            newStep.stepNumber = Int32(stepsDict["step"] as! String)! // getting STEP NUMBER
                                            
                                            let durationString = stepsDict["duration"] as? String
                                            guard let unwrappedDuration = durationString else { return }
                                            let durationInt = unwrappedDuration.convertDurationToMinutes()
                                            //print("HEY JOHANN")
                                            newStep.duration = Int32(durationInt)
                                            //Johann
                                            //newStep.duration = stepsDict["duration"] as? String  // getting DURATION
                                            
                                            
                                            
                                            let timeToStartString = stepsDict["timeToStart"] as? String
                                            guard let unwrappedTimeToStart = timeToStartString else { return }
                                            let timeToStartInt = unwrappedTimeToStart.convertTimeToStartToMinutes()
                                            newStep.timeToStart = Int32(timeToStartInt)
                                            
                                    
                                            //newStep.timeToStart = stepsDict["timeToStart"] as? String  // getting TIME TO START
                                            print(newStep)
                                            recipeRequested?.addToStep(newStep)  // add step to recipe
                                            
                                            // add ingredients to the step, if they exist
                                            let ingredientsRaw = stepsDict["ingredients"] as? [String]
                                            var ingredients:[String] = [String]()
                                            if let ingredientsWithPossibleNullValues = ingredientsRaw {
                                                if ingredientsWithPossibleNullValues.isEmpty == false {  // check to see if the ingredients are null
                                                    ingredients = ingredientsWithPossibleNullValues
                                                    for ingredient in ingredients {
                                                        let newIngredient: Ingredient = Ingredient(context: context)
                                                        newIngredient.isChecked = false   // setting default value for isChecked
                                                        newIngredient.ingredientDescription = ingredient  // getting ingredientDescription
                                                        newStep.addToIngredient(newIngredient)
                                                    }
                                                }
                                            }
                                            store.saveRecipesContext()
                                        }
                                    }
                                }
                            }
                            completion()
                        } catch {
                            print("An error occured when creating responseJSON")
                        }
                    }
                }
                task.resume()
            }

//        }else{
//            print("im not empty don't do anything")
//            completion()
//        }
        
        completion()
        
        /*
        if let recipeStepsEmptyBeforeAPIRequest = recipeRequested?.step?.allObjects.isEmpty {
            // fetch steps if needed
            
            print("Count should be at zero ")
            if recipeStepsEmptyBeforeAPIRequest {
                
                if let unwrappedUrl = url{
                    let session = URLSession.shared
                    let task = session.dataTask(with: unwrappedUrl) { (data, response, error) in
                        if let unwrappedData = data {
                            do {
                                let responseJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: []) as! [[String: Any]]
                                //print(responseJSON)
                                for stepsDict in responseJSON {
                                    let recipeIdFromStep = stepsDict["recipe"] as! String
                                    
                                    // if the step is related to the recipeRequested, get the steps and add them to the recipe in CD
                                    if recipeRequested?.id == recipeIdFromStep {
                                        
                                        let newStep: Steps = Steps(context: context)
                                        
                                        // getting STEP TITLES
                                        newStep.stepTitle = stepsDict["stepTitle"] as? String
                                        //print(newStep.stepTitle)
                                        
 
                                        let responseJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: []) as! [[String: Any]]
                                        //print(responseJSON)
                                        
                                        for stepsDict in responseJSON {
                                            let recipeIdFromStep = stepsDict["recipe"] as! String
                                            // if the step is related to the recipeRequested, get the steps and add them to the recipe in CD
                                            if recipeRequested?.id == recipeIdFromStep {
                                                
                                                let newStep: Steps = Steps(context: context)
                                                newStep.stepTitle = stepsDict["stepTitle"] as? String   // getting STEP TITLES
                                                newStep.procedure = stepsDict["procedure"] as? String   // getting STEP PROCEDURE
                                                newStep.fullAttentionRequired = Bool(stepsDict["fullAttentionRequired"] as! String)!  // getting FULL ATTENTION
                                                newStep.stepNumber = Int32(stepsDict["step"] as! String)! // getting STEP NUMBER
                                                let durationString = stepsDict["duration"] as? String
                                                guard let unwrappedDuration = durationString else { return }
                                                let durationInt = unwrappedDuration.convertDurationToMinutes()
                                                print("HEY JOHANN")
                                                print(durationInt)
                                                newStep.duration = Int32(durationInt)
                                                //Johann
                                                //newStep.duration = stepsDict["duration"] as? String  // getting DURATION
                                                newStep.timeToStart = stepsDict["timeToStart"] as? String  // getting TIME TO START
                                                recipeRequested?.addToStep(newStep)  // add step to recipe
                                                
                                                // add ingredients to the step, if they exist
                                                let ingredientsRaw = stepsDict["ingredients"] as? [String]
                                                var ingredients:[String] = [String]()
                                                if let ingredientsWithPossibleNullValues = ingredientsRaw {
                                                    if ingredientsWithPossibleNullValues.isEmpty == false {  // check to see if the ingredients are null
                                                        ingredients = ingredientsWithPossibleNullValues
                                                        for ingredient in ingredients {
                                                            let newIngredient: Ingredient = Ingredient(context: context)
                                                            newIngredient.isChecked = false   // setting default value for isChecked
                                                            newIngredient.ingredientDescription = ingredient  // getting ingredientDescription
                                                            newStep.addToIngredient(newIngredient)
                                                        }
                                                    }
                                                }
                                                store.saveRecipesContext()
                                            }
                                        }
                                    }
                                }
                                completion()
                            } catch {
                                print("An error occured when creating responseJSON")
                            }
                        }
                    }
                    task.resume()
                }
            }
            else {
                completion()
            }
            
        }
    */
    }
    
    class func fetchImage(_ url: URL, recipe: Recipe, completion: @escaping () -> Void) {
        let store = DataStore.sharedInstance
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
                    
        guard let imageData = try? Data(contentsOf: url) else { fatalError() }
        let image = UIImage(data: imageData)
        store.images.append(image!)
            OperationQueue.main.addOperation {
                completion()
            }
        }
        task.resume()
    }
            
            
            
}
