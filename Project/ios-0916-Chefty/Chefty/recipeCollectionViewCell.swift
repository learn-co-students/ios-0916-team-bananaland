//
//  recipeCollectionViewCell.swift
//  Chefty
//
//  Created by Arvin San Miguel on 11/17/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

class recipeCollectionViewCell: UICollectionViewCell {
 
    var imageView : UIImageView!
    var gradientView : UIView!
    var recipeLabel : UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        insertGradientLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        insertGradientLayer()
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
        
        gradientView = UIView()
        gradientView.layer.cornerRadius = 10.0
        gradientView.layer.masksToBounds = true
        self.contentView.addSubview(gradientView)
        
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.topAnchor.constraint(equalTo: self.imageView.topAnchor).isActive = true
        gradientView.leadingAnchor.constraint(equalTo: self.imageView.leadingAnchor).isActive = true
        gradientView.trailingAnchor.constraint(equalTo: self.imageView.trailingAnchor).isActive = true
        gradientView.bottomAnchor.constraint(equalTo: self.imageView.bottomAnchor).isActive = true
        
    }
    
    private func insertGradientLayer() {
        
        let gradient = CAGradientLayer()
        let blackColor = UIColor.black.withAlphaComponent(1.0)
        gradient.cornerRadius = 10.0
        gradient.masksToBounds = true
        gradient.colors = [UIColor.clear.cgColor, blackColor.cgColor]
        gradient.locations = [0.5, 1.0]
        gradient.startPoint = CGPoint(x: gradientView.bounds.minX, y: gradientView.bounds.minY)
        gradient.endPoint = CGPoint(x: gradientView.bounds.minX, y: gradientView.bounds.maxY)
        gradient.frame = contentView.frame
        gradientView.layer.addSublayer(gradient)
        
    }
    
}
