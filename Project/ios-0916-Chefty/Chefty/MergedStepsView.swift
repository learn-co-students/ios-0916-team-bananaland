//
//  MergedStepsView.swift
//  Chefty
//
//  Created by Jacqueline Minneman on 11/28/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import Foundation
import UIKit

class MergedStepsView: UIView {

    var store = DataStore.sharedInstance
    var steps = [RecipeStep]()
    
    override init(frame:CGRect){
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        print("merged stuff here")
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    func getAPIInfo(with completion: @escaping () -> ()) {
        store.getRecipeSteps {
            
            print("getting recipe steps")
            
            
            completion()
            
        }
        
    }
}
