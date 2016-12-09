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
    var textLabelInst:UILabel = UILabel()
    
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
        contentView.addSubview(textLabelInst)
        textLabelInst.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        textLabelInst.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 44).isActive = true
        textLabelInst.translatesAutoresizingMaskIntoConstraints = false
    }
    
}

