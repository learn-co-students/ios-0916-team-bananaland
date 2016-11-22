//
//  Ingredients.swift
//  Chefty
//
//  Created by Joanna Tzu-Hsuan Huang on 11/22/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//



class Ingredients {
    var recipeName: String!
    var recipeIngredients = [(ingredient: String, selected: Bool)]()
    
    init(name: String, ingredients: [String]) {
    //init(ingredientsDict:  [String: Any]) {
        self.recipeName = name
        for ingredient in ingredients {
            self.recipeIngredients.append((ingredient, false))
        }
        
        
        
    }
}



/*
 import Foundation
 
 final class Ingredient: CustomStringConvertible {
 
 let recipeName: String
 var recipeIngredients = [Ingredient] = []
 
 init (name: String, ingredients: [[String:String]]) {
 self.name = name
 
 for ingredient in ingredients {
 let newIngredient = Ingredient(dictionary: ingredient)
 recipeIngredients.append(newIngredient)
 }
 }
 
 var description: String {
 
 var result: String = ""
 
 result += "Name: \(name)\n"
 
 for ingredient in recipeIngredients {
 result += "\(ingredient)\n"
 }
 
 result += "\n\n"
 
 return result
 
 }
 
 
 }
 */
