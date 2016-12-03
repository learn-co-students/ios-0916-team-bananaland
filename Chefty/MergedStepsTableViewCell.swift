//
//  MergedStepsTableViewCell.swift
//  Chefty
//
//  Created by Jacqueline Minneman on 12/3/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import Foundation

class MergedStepsTableViewCell: UITableViewCell {
    
    var imageViewInst:UIImageView = UIImageView()
    
    required init(coder aDecoder: NSCoder) { fatalError("init(coder:)") }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //image
        contentView.addSubview(imageViewInst)
        imageViewInst.topAnchor.constraint(equalTo: self.topAnchor, constant: 3).isActive = true
        imageViewInst.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -3).isActive = true
        imageViewInst.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 3).isActive = true
        imageViewInst.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.08).isActive = true
        
        
        imageViewInst.translatesAutoresizingMaskIntoConstraints = false
        
        
        //text label
        
        textLabel?.trailingAnchor.constraint(equalTo: imageViewInst.trailingAnchor, constant: 100).isActive = true
        textLabel?.translatesAutoresizingMaskIntoConstraints = false
    }
    
}

