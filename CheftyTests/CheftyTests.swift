//
//  CheftyTests.swift
//  CheftyTests
//
//  Created by Paul Tangen on 12/9/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import XCTest
import CoreData

class CheftyTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    class MockDataProvider: NSObject {
        
        var context: NSManagedObjectContext?
//        weak var tableView: UITableView!
//        func addRecipe(personInfo: PersonInfo) { }
//        func fetch() { }
//        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 1 }
//        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//            return UITableViewCell()
//        }
        
        let recipeInst = NSEntityDescription.insertNewObject(forEntityName: "Recipe", into: context) as! Recipe
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
