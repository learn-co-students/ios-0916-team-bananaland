//
//  FoodItem.swift
//  Chefty
//
//  Created by Joanna Tzu-Hsuan Huang on 11/22/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//


 import Foundation


final class FoodItem: CustomStringConvertible {
    
    let name: String
    var stepsToMakeFood: [Ingredient] = []
    
    init(name: String, ingredients: [[String : String]]) {
        self.name = name
        
        for ingredient in ingredients {
            let newIngredient = Ingredient(dictionary: ingredient)
            stepsToMakeFood.append(newIngredient)
        }
        
    }
    
    var description: String {
        
        var result: String = ""
        
        result += "Name: \(name)\n"
        
        for ingredient in stepsToMakeFood {
            
            result += "\(ingredient)\n"
            
        }
        
        result += "\n\n"
        
        return result
        
    }
}



final class Ingredient: CustomStringConvertible {
    
    let ingredientsDescription: String
    let step: String
    
    init(dictionary: [String : String]) {
        
        step = dictionary["step"] ?? "No Step"
        ingredientsDescription = dictionary["description"] ?? "n/a"
    }
    
    var description: String {
        
        return ingredientsDescription
        
    }
    
}
 
