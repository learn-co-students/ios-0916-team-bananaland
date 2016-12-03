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
        
        contentView.backgroundColor = UIColor.blue
        
        //image
        contentView.addSubview(imageViewInst)
        imageViewInst.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageViewInst.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        imageViewInst.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        imageViewInst.translatesAutoresizingMaskIntoConstraints = false

        
    }
    
}
