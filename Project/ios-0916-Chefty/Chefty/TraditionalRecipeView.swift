//
//  TraditionalRecipeView.swift
//  Chefty
//
//  Created by Jacqueline Minneman on 11/17/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//


import UIKit

class TraditionalRecipeView: UIView {
    
    override init(frame:CGRect){
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        //IMAGE
        // create image
        let myImageName = "applePie"
        let myImage = UIImage(named: myImageName)
        let myImageView = UIImageView(image: myImage!)
        
        // add the image
        self.addSubview(myImageView)
        
        // constrain the image
        myImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 25).isActive = true
        myImageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        //TITLE
        //create title label
        let titleLabel = UILabel()
        titleLabel.text = "Recipe Title"
        titleLabel.font = titleLabel.font.withSize(40)
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = UIColor.red
        
        
        //add the title label
        self.addSubview(titleLabel)
        
        // constrain the image
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: myImageView.bottomAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
