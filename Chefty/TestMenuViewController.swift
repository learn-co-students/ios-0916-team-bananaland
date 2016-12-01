//
//  TestMenuViewController.swift
//  Chefty
//
//  Created by Arvin San Miguel on 11/30/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

class TestMenuViewController: UIViewController {

    var store = DataStore.sharedInstance
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
   
}


extension TestMenuViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.recipesSelected.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "testMenuCell", for: indexPath) as! TestMenuTableViewCell
        
        cell.recipe = store.recipesSelected[indexPath.row]
        let url = URL(string: (cell.recipe?.imageURL)!)
        if let url = url {
            cell.imageView?.sd_setImage(with: url)
        }
        
        return cell
    }
    
    
}

