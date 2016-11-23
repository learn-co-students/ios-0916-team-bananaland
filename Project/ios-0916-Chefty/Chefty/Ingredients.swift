//
//  FoodItem.swift
//  Chefty
//
//  Created by Joanna Tzu-Hsuan Huang on 11/22/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//


import Foundation

final class Ingredients: CustomStringConvertible {
    
    typealias Parts = [(name: String, ingredients: [(desc: String, isChecked: Bool)])]
    
    var parts: Parts = []
    
//    private(set) var parts: [(name: String, ingredients: [String])] = []
//    private(set) var terms: [(name: String, ingredients: [(description: String, isChecked: Bool)])] = []
    
    init(json: [String : [[String : String]]]) {
        
        self.parts = generateIngredientsFrom(json: json)
        
    }
    
    private func generateIngredientsFrom(json: [String : [[String : String]]]) -> Parts {
        
        var ingredientsFromJSON: Parts = []
        
        json.forEach { (key, value) in
            
            var recipeWords = key.components(separatedBy: "-")
            recipeWords = recipeWords.map { (word) -> String in
                let uppercasedLetter = String(word.characters.prefix(1)).uppercased()
                let letters = String(word.characters.dropFirst())
                return uppercasedLetter + letters
            }
            
            let recipeName = recipeWords.joined(separator: " ")
            
            var ingredientsFromDescription = [(desc: String, isChecked: Bool)]()
            
            value.forEach({ (recipe) in
                
                let descriptionTuple = (
                    desc: recipe["description"]!,
                    isChecked: false
                )
                
                ingredientsFromDescription.append(descriptionTuple)
                
            })
            
            let ingredientsTuple = (
                name: recipeName,
                ingredients: ingredientsFromDescription
            )
            
            ingredientsFromJSON.append(ingredientsTuple)
            
        }
        
        return ingredientsFromJSON
        
    }
    
    var description: String {
        
        var description = ""
        
        parts.forEach { recipe in
            
                description += "Recipe Name: \(recipe.name)\n\n"
                description += "Ingredients: \(recipe.ingredients)\n\n"
        
        }
        return description
        
    }
    
}



 
