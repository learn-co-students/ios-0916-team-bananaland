//
//  WelcomeView.swift
//  Chefty
//
//  Created by Paul Tangen on 11/22/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

// protocol/delegate needed to segue from our parent view controller to another view controller
protocol WelcomeViewDelegate: class {
    func goToHome(button: UIButton)
}

class WelcomeView: UIView {

    weak var delegate:WelcomeViewDelegate!
    
    override init(frame:CGRect){
        super.init(frame: frame)
        
        // initialize button
        let pageLabel: UILabel = UILabel()
        
        let openRecipeButton: UIButton = UIButton(type: .roundedRect)
        
        // configure controls
        pageLabel.text = "Choose a view controller to open."
        pageLabel.font =  UIFont(name: "Helvetica", size: CGFloat(Constants.fontSize.small.rawValue))
        
        openRecipeButton.setTitle("Welcome to Chefty", for: .normal)
        openRecipeButton.addTarget(self, action: #selector(self.onClickRecipeButton), for: UIControlEvents.touchUpInside)
        
        // add the object to the view
        self.addSubview(pageLabel)
        self.addSubview(openRecipeButton)
        
        // constrain the object
        pageLabel.translatesAutoresizingMaskIntoConstraints = false
        pageLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 100).isActive = true
        pageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        openRecipeButton.translatesAutoresizingMaskIntoConstraints = false
        openRecipeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 200).isActive = true
        openRecipeButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 100).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func onClickRecipeButton(openRecipeButton:UIButton) {
        self.delegate.goToHome(button: openRecipeButton)
    }

}
