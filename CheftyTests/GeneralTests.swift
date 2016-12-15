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
    
    func testRecipeProperties() {
        
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
    }
    
    func testRecipeSelected() {
        
        var recipeForTesting: Recipe?
        for recipe in store.recipes {
            if recipe.id == "apple-pie" {
                recipeForTesting = recipe
                break
            }
        }
        
        // determine if the recipeSelected array can be populated.
        if self.store.recipesSelected.count > 0 {
            XCTAssert(self.store.recipesSelected.count > 0)
        } else {
            // we dont have a selected recipe to try to select one and then unselect it
            if let recipeForTesting = recipeForTesting {
                store.setRecipeSelected(recipe: recipeForTesting)
                XCTAssert(recipeForTesting.selected == true)
                XCTAssert(store.recipesSelected.count == 1) // selected one recipe, so value should be 1
                store.setRecipeUnselected(recipe: recipeForTesting)
                XCTAssert(recipeForTesting.selected == false)
                XCTAssert(store.recipesSelected.count == 0) // unseelcted the only recipe, value should be 0
            }
        }
    }
    
    func testStepsAndIngredients() {
        
        var recipeForTesting: Recipe?
        for recipe in store.recipes {
            if recipe.id == "apple-pie" {
                recipeForTesting = recipe
                break
            }
        }
        
        let expectationResult = expectation(description: "Wait for steps to be returned from API.")
        var stepCount = Int()
    
        // fetch the steps and ingredients
        CheftyAPIClient.getStepsAndIngredients(recipe: recipeForTesting!) {
            
            stepCount = (recipeForTesting?.steps?.count)!
            expectationResult.fulfill()
            
        }
        waitForExpectations(timeout: 10, handler: nil)
        print(stepCount)
        XCTAssert(stepCount == 15) // apple-pie stepCount = 15
        
        if let recipeForTesting = recipeForTesting {
            var steps = recipeForTesting.steps?.allObjects as! [Step]
            steps = steps.sorted(by: { $0.timeToStart < $1.timeToStart } )
            let ingredientsFirstStepCount = steps.first?.ingredients?.allObjects.count
            XCTAssert(ingredientsFirstStepCount == 5) // the first step of apple pie has 5 ingredients
        }
    }
}
