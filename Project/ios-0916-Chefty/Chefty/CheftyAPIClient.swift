//
//  CheftyAPIClient.swift
//  Chefty
//
//  Created by Paul Tangen on 11/17/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import Foundation

class CheftyAPIClient {
    
    class func getRecipies(completion: @escaping () -> Void) {
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
    
    class func getIngredients(completion: @escaping () -> Void){
    
        print("getting ingredients")
        let store = DataStore.sharedInstance
        let urlString = "\(Secrets.cheftyAPIURL)/getIngredients.php?key=\(Secrets.cheftyKey)&recipe1=chicken-breasts&recipe2=sweet-potato-fries&recipe3=peach-cobbler&recipe4=beef-broccoli-stir-fry"
        
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession.shared
    
        let task = session.dataTask(with: url) { (data, response, error) in
            if let unwrappedData = data {
                do {
                    let responseJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: []) as! [[String: String]]
                    
                    for ingredientDict in responseJSON {
                        let ingredientInst = Ingredient(ingredientDict: ingredientDict)
                        store.ingredientsArray.append(ingredientInst) // add to ingredientsArray in datastore
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
