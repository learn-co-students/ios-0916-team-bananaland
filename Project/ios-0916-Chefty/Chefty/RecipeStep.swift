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
    var stepNumber: Int?
    //var duration: Date?
    //var timeToStart: Date?
    var fullAttentionRequired: Bool?
    var stepTitle: String?
    var procedure: String?
    var ingredients: [String]?
    
    
    init(dict: [String: Any]) {
        self.recipeID = dict["recipe"] as! String?
        self.stepNumber = Int((dict["step"] as! String?)!)
        
//        let durationDouble = Double(dict["duration"] as! String?)!)
//        self.duration = Date(durationDouble)
        
//        let durationString = dict["duration"] as! String?
//        let dayTimePeriodFormatter = DateFormatter()
//        dayTimePeriodFormatter.dateFormat = "HH:mm:ss"
//        let dateString = dayTimePeriodFormatter.string(from: durationString as! Date)
        
        
        //self.duration = Date(timeIntervalSince1970: durationDouble!)
        
//        let timeToStartDouble = Double(((dict["timeToStart"]) as! String?)!)
//        self.timeToStart = Date(timeIntervalSince1970: timeToStartDouble!)
        
        self.fullAttentionRequired = Bool(((dict["fullAttentionRequired"] as! String?)!))
        self.stepTitle = dict["stepTitle"] as! String?
        self.procedure = dict["procedure"] as! String?
        self.ingredients = dict["ingredients"] as! [String]?
    }
    
}
