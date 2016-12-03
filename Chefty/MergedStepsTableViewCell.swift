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
        imageViewInst.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
        imageViewInst.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 4).isActive = true
        imageViewInst.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        imageViewInst.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1).isActive = true
        imageViewInst.translatesAutoresizingMaskIntoConstraints = false

        
    }
    
}
