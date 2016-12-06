//
//  IngredientsTableViewCell.swift
//  Chefty
//
//  Created by Joanna Tzu-Hsuan Huang on 12/5/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import Foundation

class IngredientsTableViewCell: UITableViewCell {
    
    var checkBox:UIImageView = UIImageView()
    let uncheckedBox: UIImage = UIImage()
    let checkedBox: UIImage = UIImage()
    
    
    
    required init(coder aDecoder: NSCoder) { fatalError("init(coder:)") }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // checkBox
        contentView.addSubview(checkBox)
        
        checkBox.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
        checkBox.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        checkBox.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.45).isActive = true
        checkBox.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.05).isActive = true
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        checkBox.backgroundColor = UIColor.clear
        
        
        //text label
        textLabel?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        textLabel?.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        textLabel?.numberOfLines = 0
        textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        textLabel?.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -3).isActive = true
        textLabel?.translatesAutoresizingMaskIntoConstraints = false
        textLabel?.adjustsFontSizeToFitWidth = true
       
    }
    

    
}

