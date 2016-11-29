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
    var fullAttentionRequired: Bool?
    var stepTitle: String?
    var procedure: String?
    var ingredients: [String]?
    
    var duration: Int?
    var timeToStart: Int?
    
    
    init(dict: [String: Any]) {
        self.recipeID = dict["recipe"] as! String?
        self.stepNumber = Int((dict["step"] as! String?)!)
        self.fullAttentionRequired = Bool(((dict["fullAttentionRequired"] as! String?)!))
        self.stepTitle = dict["stepTitle"] as! String?
        self.procedure = dict["procedure"] as! String?
        self.ingredients = dict["ingredients"] as! [String]?

        let durationSeconds = convertStringToMinutes(input: (dict["duration"] as! String?)!)
        self.duration = durationSeconds
        
        let timeToStartSeconds = convertStringToMinutes(input: (dict["timeToStart"] as! String?)!)
        self.timeToStart = timeToStartSeconds
        
    }
}

extension RecipeStep {
    
    func convertStringToMinutes(input: String) -> Int {
        let separatedNum = input.components(separatedBy: ":")
        let handleMinutesOnly = Int(separatedNum[0])
        let handleHours = Int(separatedNum[0])
        let handleMinutesWithHours = Int(separatedNum[1])
        var totalMinutes: Int = 0
        
        switch separatedNum.count {
        case 2:
            totalMinutes += handleMinutesOnly!
        case 3:
            totalMinutes += ((handleHours! * 60) + (handleMinutesWithHours!))
        default:
            print("error")
        }
        
        return totalMinutes
    }
    
    
    
}
