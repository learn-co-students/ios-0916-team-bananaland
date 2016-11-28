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
    
    var recipeID: String?
    var stepNumber: String?
    var duration: Int?
    var timeToStart: Int?
    var fullAttentionRequired: Bool?
    var stepTitle: String?
    var procedure: String?
    var ingredients: [String]?
    
    
    init(dict: [String: Any]) {
        self.recipeID = dict["recipe"] as! String?
        self.stepNumber = dict["step"] as! String?
        self.duration = Int((dict["duration"] as! String?)!)
        self.timeToStart = Int((dict["timeToStart"] as! String?)!)
        self.fullAttentionRequired = Bool(((dict["fullAttentionRequired"] as! String?)!))
        self.stepTitle = dict["stepTitle"] as! String?
        self.procedure = dict["procedure"] as! String?
        self.ingredients = dict["ingredients"] as! [String]?
    }
    
}
