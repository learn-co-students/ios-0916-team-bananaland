//
//  TempView.swift
//  Chefty
//
//  Created by Paul Tangen on 11/17/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

protocol TempViewDelegate {
    func onPressMyMenuButton(button: UIButton)
}


class TempView: UIView {
    
    var delegate:TempViewDelegate!

    override init(frame:CGRect){
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.yellow
        
        // initialize button
        let myMenuButton: UIButton = UIButton(type: .roundedRect)
        let pageLabel: UILabel = UILabel()
        
        // configure controls
        pageLabel.text = "Welcome to the Chefty Temp Page"
        pageLabel.font =  UIFont(name: "Helvetica", size: CGFloat(Constants.fontSize.medium.rawValue))
        myMenuButton.setTitle("Open MyMenu", for: .normal)
        myMenuButton.addTarget(self, action: #selector(self.myMenuAction), for: UIControlEvents.touchUpInside)
        
        // add the object to the view
        self.addSubview(pageLabel)
        self.addSubview(myMenuButton)
        
        // constrain the object
        pageLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 100).isActive = true
        pageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        pageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        myMenuButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 200).isActive = true
        myMenuButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 100).isActive = true
        myMenuButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func myMenuAction(myMenuButton:UIButton) {
        self.delegate.onPressMyMenuButton(button: myMenuButton)
    }

}
