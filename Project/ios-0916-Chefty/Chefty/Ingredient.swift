//
//  FoodItem.swift
//  Chefty
//
//  Created by Joanna Tzu-Hsuan Huang on 11/22/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//


import Foundation

final class Ingredient {

    let recipeID: String
    let description: String
    var isChecked: Bool = false
    
   init(ingredientDict: [String: String])  {
        self.recipeID = ingredientDict["recipeID"] as String!
        self.description = ingredientDict["description"] as String!
    }
}
