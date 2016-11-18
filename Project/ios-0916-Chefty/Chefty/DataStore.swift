//
//  DataStore.swift
//  Chefty
//
//  Created by Paul Tangen on 11/17/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import Foundation

class DataStore {
    static let sharedInstance = DataStore()
    fileprivate init() {}

    var recipes:[Recipe] = []  // the datastore contains an array of dictionaries

    func getRecipes(completion: @escaping () -> ()) {
        
        CheftyAPIClient.getRecipies {_ in 
            //dump(self.recipes)
            completion() // call back to onViewDidLoad
        }
    }
}
