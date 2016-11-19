//
//  Recipe.swift
//  Chefty
//
//  Created by Paul Tangen on 11/18/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import Foundation

class Recipe {

    var displayName: String
    var id: String
    var imageURL: String
    var servings: String
    var type: Constants.recipeType
    var selected: Bool
    var imageData: NSData = NSData()

    // custom initializer is needed to allow a default value for selected
    init(recipeDict: [String: String]) {
        self.displayName = recipeDict["displayName"] as String!
        self.id = recipeDict["id"] as String!
        self.imageURL = recipeDict["imageURL"] as String!
        self.servings = recipeDict["servings"] as String!
        self.selected = false
        self.type = .undefined // xcode requires this...
        
        // set type per the recipeType enum
        if let typeString = recipeDict["type"] as String! {
            
            switch typeString {
            case "main":
                self.type = .main
            case "side":
                self.type = .side
            case "appetizer":
                self.type = .appetizer
            case "dessert":
                self.type = .dessert
            default:
                self.type = .undefined
            }
        }
    }
}
