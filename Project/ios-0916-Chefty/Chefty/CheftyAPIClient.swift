//
//  CheftyAPIClient.swift
//  Chefty
//
//  Created by Paul Tangen on 11/17/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import Foundation


class CheftyAPIClient {
    
    class func getRecipes(completion: @escaping () -> Void) {
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
                            //print("recipe: \(recipe)")
                            let recipeInst = Recipe(recipeDict: recipeDict)
                            store.recipes.append(recipeInst) // add to recipes in datastore
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
    
 
    class func getRecipeSteps(with completion: @escaping ()-> Void) {
        let store = DataStore.sharedInstance
        let recipeID = "apple-pie"
        let urlString = "\(Secrets.cheftyAPIURL)/getRecipeSteps.php?key=\(Secrets.cheftyKey)=\(recipeID)"
        let url = URL(string: urlString)
        
        if let unwrappedUrl = url{
            let session = URLSession.shared
            let task = session.dataTask(with: unwrappedUrl) { (data, response, error) in
                
                if let unwrappedData = data {
                    do {
                        let responseJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: []) as! [String: [[String : Any]]]
                        
                        for stepDict in responseJSON {
                            let newStep = RecipeStep(stepDict: stepDict)
                            store.recipeSteps.append(newStep)
                        }
                        
                        completion()
                        print(responseJSON)
                    } catch {
                        print("An error occured when creating responseJSON")
                    }
                }
            }
            task.resume()
        }
    }
}
