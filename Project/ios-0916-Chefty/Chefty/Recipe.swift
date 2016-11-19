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
    var type: Constants.recipeType
    var selected: Bool
    var imageData: NSData = NSData()
    var image: UIImage = UIImage()

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
    
    class func getImage(recipe: Recipe, imageView: UIImageView, view: UIView) {
        
        if recipe.image.cgImage?.bitmapInfo == nil {
            let imageUrl:URL = URL(string: recipe.imageURL)!
            // Start background thread so that image loading does not make app unresponsive
            DispatchQueue.global(qos: .userInitiated).async {
                let imageData = NSData(contentsOf: imageUrl)!
                // When from background thread, UI needs to be updated on main_queue
                DispatchQueue.main.async {
                    recipe.image = UIImage(data: imageData as Data)!
                    imageView.image = recipe.image
                    imageView.contentMode = UIViewContentMode.scaleAspectFit
                    view.addSubview(imageView)
                    imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 300).isActive = true
                }
            }
        } else {
            // the instance has the image so create the imageView
            imageView.image = recipe.image
            imageView.contentMode = UIViewContentMode.scaleAspectFit
            view.addSubview(imageView)
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 400).isActive = true
        }
    }
}
