//
//  APITests.swift
//  Chefty
//
//  Created by Paul Tangen on 12/11/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import XCTest
import CoreData
@testable import Chefty

class APITests: XCTestCase {
    
    let store = DataStore.sharedInstance
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testVerifyRecipeCreation() {
        // must run the app before running this test
        XCTAssert(self.store.recipes.count == 15)
        XCTAssertNotNil(self.store.recipes[0].servings)
    }
    
    func testVerifyRecipeProperties() {
        
        var recipeForTesting: Recipe?
        for recipe in store.recipes {
            if recipe.id == "apple-pie" {
                recipeForTesting = recipe
                break
            }
        }
            
        // test for the properties
        if let recipeForTesting = recipeForTesting {
            XCTAssert(recipeForTesting.servings == "6-8")
        }
        
        // set the recipe as selected, add to recipesSelected array
        if let recipeForTesting = recipeForTesting {
            store.setRecipeSelected(recipe: recipeForTesting)
        }
        
        // test for the properties
        if let recipeForTesting = recipeForTesting {
            XCTAssert(recipeForTesting.selected == true)
            XCTAssert(store.recipesSelected.count == 1)
        }
    }
    
}
