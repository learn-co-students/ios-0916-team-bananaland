//
//  TestMenuViewController.swift
//  Chefty
//
//  Created by Arvin San Miguel on 11/30/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit
import Foundation

class TestMenuTableViewController: UITableViewController {

    var store = DataStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.recipesSelected.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TestMenuTableViewCell
        cell.layoutMargins = UIEdgeInsetsMake(0.01, 0.01, 0.01, 0.01)
        cell.recipe = store.recipesSelected[indexPath.row]
        guard let url = URL(string: (cell.recipe?.imageURL)!) else { fatalError() }
        cell.imageView?.contentMode = .scaleAspectFill
        cell.recipeLabel.text = cell.recipe?.displayName
        cell.selectedRecipeImage.sd_setImage(with: url)
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let testView = TestTraditionalRecipeViewController()
        testView.modalTransitionStyle = .crossDissolve
        testView.recipe = store.main[indexPath.row]
        present(testView, animated: true, completion: nil)
    }
    
    
    
    
    
}




