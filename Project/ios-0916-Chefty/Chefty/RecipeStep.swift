//
//  RecipeSteps.swift
//  Chefty
//
//  Created by Jacqueline Minneman on 11/25/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import Foundation
import UIKit

class RecipeStep {
    
    var recipeID: String
    var stepNumber: String
    var duration: String
    var timeToStart: String
    var fullAttentionRequired: String
    //var ingredients: [String: String]
    var stepTitle: String
    var procedure: String
    
    init(stepDict: [String: [String: Any]]) {
        let dict = stepDict["results"]
        self.recipeID = dict?["recipe"] as! String!
        self.stepNumber = dict?["step"] as! String!
        self.duration = dict?["duration"] as! String!
        self.timeToStart = dict?["timeToStart"] as! String!
        self.fullAttentionRequired = dict?["fullAttentionRequired"] as! String!
        //self.ingredients = dict["ingredients"] as! String!
        self.stepTitle = dict?["stepTitle"] as! String!
        self.procedure = dict?["procedure"] as! String!
    }
}

