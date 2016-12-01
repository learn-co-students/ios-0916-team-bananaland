//
//  MergedStepsView.swift
//  Chefty
//
//  Created by Jacqueline Minneman on 11/28/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import Foundation
import UIKit

//delete this page in master!!!! 


class MergedStepsView: UIView {

    var store = DataStore.sharedInstance
    var steps = [RecipeStep]()
    
    override init(frame:CGRect){
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        //setUpElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpElements() {
        
        //textbox
        let myTextBox = UITextView()
        myTextBox.text = store.recipeProceduresMerged
        myTextBox.font = myTextBox.font?.withSize(40)
        myTextBox.textAlignment = .left
        self.addSubview(myTextBox)
        
        myTextBox.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        myTextBox.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        myTextBox.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        myTextBox.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        myTextBox.translatesAutoresizingMaskIntoConstraints = false
        
    }

    
}
