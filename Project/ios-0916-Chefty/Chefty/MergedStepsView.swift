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
    var mergedStepsVC: MergedStepsViewController!
    
    override init(frame:CGRect){
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        setUpElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpElements() {
        
        //textbox
        let myTextBox = UITextView()
        //let text = mergedStepsVC.stepsForDisplayString
        myTextBox.text = store.recipeProceduresMerged
        myTextBox.textAlignment = .center
        
        self.addSubview(myTextBox)
        
        myTextBox.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        myTextBox.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        myTextBox.heightAnchor.constraint(equalToConstant: 200).isActive = true
        myTextBox.widthAnchor.constraint(equalToConstant: 200).isActive = true
        myTextBox.translatesAutoresizingMaskIntoConstraints = false
        
        
    }

    
}
