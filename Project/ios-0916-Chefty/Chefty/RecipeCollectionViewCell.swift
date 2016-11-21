//
//  recipeCollectionViewCell.swift
//  Chefty
//
//  Created by Arvin San Miguel on 11/17/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit
import AVFoundation


class RecipeCollectionViewCell: UICollectionViewCell {
 
    var imageView : UIImageView!
    var gradientView : GradientView!
    var recipeLabel : UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        
        //layout ImageView
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10.0
        imageView.layer.masksToBounds = true
        self.contentView.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        
        //layout GradientView
        gradientView = GradientView(frame: imageView.frame)
        gradientView.layer.cornerRadius = 10.0
        gradientView.layer.masksToBounds = true
        self.contentView.addSubview(gradientView)
        
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        gradientView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        gradientView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        gradientView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        
        let recipeFrame = CGRect(x: 0, y: bounds.height * 0.75, width: bounds.width, height: bounds.height * 0.20)
        recipeLabel = UILabel(frame: recipeFrame)
        recipeLabel.font = UIFont(name: "GillSans-SemiBold", size: 20)
        recipeLabel.textAlignment = .center
        recipeLabel.textColor = UIColor.white
        recipeLabel.numberOfLines = 0
        self.contentView.addSubview(recipeLabel)
        
        recipeLabel.translatesAutoresizingMaskIntoConstraints = false
        recipeLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        recipeLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        recipeLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        
    }
}
