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
    var servingTime: Date = Date()
    //var imageData: Data = Data()
    var selected: Bool = false
    //var image: UIImage = UIImage()

    // custom initializer is needed to allow a default value for selected
    init(recipeDict: [String: String]) {
        self.displayName = recipeDict["displayName"] as String!
        self.id = recipeDict["id"] as String!
        self.imageURL = recipeDict["imageURL"] as String!
        self.servings = recipeDict["servings"] as String!
        self.selected = false
        self.type = recipeDict["type"] as String!
    }

    // use pod instead
//    class func getImage(recipe: Recipe, imageView: UIImageView, view: UIView, backgroundImage: Bool) {
//        
//        if recipe.image.cgImage?.bitmapInfo == nil {
//            print("no image found in object")
//            let imageUrl:URL = URL(string: recipe.imageURL)!
//            // Start background thread so that image loading does not make app unresponsive
//            DispatchQueue.global(qos: .userInitiated).async {
//                let imageData = NSData(contentsOf: imageUrl)!
//                // When from background thread, UI needs to be updated on main_queue
//                DispatchQueue.main.async {
//                    recipe.imageData = imageData as Data
//                    recipe.image = UIImage(data: recipe.imageData)!
//                    if backgroundImage == true {
//                        imageView.backgroundColor = UIColor(patternImage: UIImage(data: recipe.imageData)!)
//                    } else {
//                        imageView.image = recipe.image
//                        imageView.contentMode = UIViewContentMode.scaleAspectFit
//                    }
//                    view.addSubview(imageView)
//                    view.sendSubview(toBack: imageView)
//                }
//            }
//        } else {
//            if backgroundImage == true {
//                imageView.backgroundColor = UIColor(patternImage: UIImage(data: recipe.imageData)!)
//            } else {
//                imageView.image = recipe.image
//                imageView.contentMode = UIViewContentMode.scaleAspectFit
//            }
//            view.addSubview(imageView)
//            view.sendSubview(toBack: imageView)
//        }
//    }
// here is an example of getting data from a UIImage object
//    if let img = UIImage(named: "hallo.png") {
//        let data = UIImagePNGRepresentation(img) as NSData?
//    }
    
}
