//
//  Recipe.swift
//  Chefty
//
//  Created by Paul Tangen on 11/18/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import Foundation
import UIKit

class Recipe {

    var displayName: String
    var id: String
    var imageURL: String
    var servings: String
    var type: String
    var servingTime: Date {
        let calendarInst = Calendar(identifier: .gregorian)
        var componentsServingTime = DateComponents()
        componentsServingTime.year = calendarInst.component(.year, from: Date())
        componentsServingTime.month = calendarInst.component(.month, from: Date())
        componentsServingTime.day = calendarInst.component(.day, from: Date())
        componentsServingTime.hour = 19
        componentsServingTime.minute = 00
        componentsServingTime.second = 00
        let servingTime = calendarInst.date(from: componentsServingTime)!
        return servingTime
    }
    var imageData: NSData = NSData()
    var selected: Bool = false
    var sortValue: Int

    // custom initializer is needed to allow a default value for selected
    init(recipeDict: [String: String]) {
        self.displayName = recipeDict["displayName"] as String!
        self.id = recipeDict["id"] as String!
        self.imageURL = recipeDict["imageURL"] as String!
        self.servings = recipeDict["servings"] as String!
        self.type = recipeDict["type"] as String!
        self.selected = false
        let sortValueString = recipeDict["sortValue"] as String!
        self.sortValue = Int(sortValueString!)!
    }
    
    func getServingTime(hours: Int, minutes: Int) -> Date {
        let calendarInst = Calendar(identifier: .gregorian)
        var componentsServingTime = DateComponents()
        componentsServingTime.year = calendarInst.component(.year, from: Date())
        componentsServingTime.month = calendarInst.component(.month, from: Date())
        componentsServingTime.day = calendarInst.component(.day, from: Date())
        componentsServingTime.hour = hours
        componentsServingTime.minute = minutes
        componentsServingTime.second = 00
        let servingTime = calendarInst.date(from: componentsServingTime)!
        return servingTime
    }

    class func getBackgroundImage(recipeSelected: RecipeSelected, imageView: UIImageView, view: UIView) {
    // The tableview cells crop images nicely when they are background images. This function gets a background image, stores it in the object and then sets it on the imageView that was passed in.
        if let imageURL = recipeSelected.imageURL {
            // cant find a image data property to evaluate to determine in the field is populated
            //print(recipeSelected.imageData?. )
            //if let imageDate = recipeSelected.imageData {
                //print("no image data found in object")
                let imageUrl:URL = URL(string: imageURL)!
                // Start background thread so that image loading does not make app unresponsive
                DispatchQueue.global(qos: .userInitiated).async {
                    let imageData = NSData(contentsOf: imageUrl)!
                    // When from background thread, UI needs to be updated on main_queue
                    DispatchQueue.main.async {
                        recipeSelected.imageData = imageData
                        //print(recipe.imageData)
                        imageView.backgroundColor = UIColor(patternImage: UIImage(data: recipeSelected.imageData as! Data)!)
                        view.addSubview(imageView)
                        view.sendSubview(toBack: imageView)
                    }
                }
           // } else {
//                print("image data was found in object")
//                imageView.backgroundColor = UIColor(patternImage: UIImage(data: recipeSelected.imageData as! Data)!)
//                view.addSubview(imageView)
//                view.sendSubview(toBack: imageView)
//            }
        }
    }

}
