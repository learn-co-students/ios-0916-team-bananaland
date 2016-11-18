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
                            var recipeInst = Recipe(recipeDict: recipeDict)
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
}
