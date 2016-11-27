//
//  MyMenuTableViewCell.swift
//  Chefty
//
//  Created by Paul Tangen on 11/19/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

protocol MyMenuTableViewCellDelegate: class {
    func updateTableViewNow()
}

class MyMenuTableViewCell: UITableViewCell {
    
    var store = DataStore.sharedInstance
    weak var delegate: MyMenuTableViewCellDelegate?
    var gradientView: GradientView!
    var gradientViewLeftToRight: GradientViewLeftToRight!
    var servingTimeField:UITextField = UITextField()
    var recipeDescField:UITextField = UITextField()
    var imageView1:UIImageView = UIImageView()
    let deleteButton: UIButton = UIButton(type: .roundedRect)

    override func awakeFromNib() { super.awakeFromNib() }

    override func setSelected(_ selected: Bool, animated: Bool) { super.setSelected(selected, animated: animated) }

    required init(coder aDecoder: NSCoder) { fatalError("init(coder:)") }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // background image
        contentView.addSubview(imageView1)
        imageView1.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView1.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        imageView1.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        //layout GradientView
        gradientView = GradientView(frame: imageView1.frame)
        gradientView.layer.cornerRadius = 10.0
        gradientView.layer.masksToBounds = true
        self.contentView.addSubview(gradientView)
        
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        gradientView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        gradientView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        gradientView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        
        gradientViewLeftToRight = GradientViewLeftToRight(frame: imageView1.frame)
        gradientViewLeftToRight.layer.cornerRadius = 10.0
        gradientViewLeftToRight.layer.masksToBounds = true
        self.contentView.addSubview(gradientViewLeftToRight)
        
        gradientViewLeftToRight.translatesAutoresizingMaskIntoConstraints = false
        gradientViewLeftToRight.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        gradientViewLeftToRight.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        gradientViewLeftToRight.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        gradientViewLeftToRight.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        
        imageView1.translatesAutoresizingMaskIntoConstraints = false
        
        // cell label
        self.servingTimeField.textColor = UIColor.white
        self.servingTimeField.font =  UIFont(name: Constants.appFont.bold.rawValue, size: CGFloat(Constants.fontSize.medium.rawValue))
        contentView.addSubview(self.servingTimeField)
        self.servingTimeField.widthAnchor.constraint(equalToConstant: 50)
        self.servingTimeField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        self.servingTimeField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        //self.servingTimeField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        self.servingTimeField.translatesAutoresizingMaskIntoConstraints = false
        
        // recipeDescField
        self.recipeDescField.textColor = UIColor.white
        self.recipeDescField.isUserInteractionEnabled = false
        self.recipeDescField.font =  UIFont(name: Constants.appFont.bold.rawValue, size: CGFloat(Constants.fontSize.medium.rawValue))
        contentView.addSubview(self.recipeDescField)
        self.recipeDescField.bottomAnchor.constraint(equalTo: servingTimeField.bottomAnchor).isActive = true
        self.recipeDescField.leftAnchor.constraint(equalTo: servingTimeField.rightAnchor, constant: 10).isActive = true
        self.recipeDescField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        self.recipeDescField.translatesAutoresizingMaskIntoConstraints = false
        
        // delete button
        let deleteButton: UIButton = UIButton(type: .roundedRect)
        deleteButton.setTitle(Constants.iconLibrary.close.rawValue, for: .normal)
        deleteButton.titleLabel!.font =  UIFont(name: Constants.iconFont.material.rawValue, size: CGFloat(Constants.iconSize.xsmall.rawValue))
        deleteButton.setTitleColor(UIColor(named: .white), for: .normal)
        deleteButton.addTarget(self, action: #selector(MyMenuTableViewCell.onClickDeleteAction), for: UIControlEvents.touchUpInside)
        contentView.addSubview(deleteButton)
        deleteButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        deleteButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func onClickDeleteAction() {
        if let currentRowString = self.deleteButton.accessibilityLabel {
            if let currentRow = Int(currentRowString) {
                let context = store.persistentContainer.viewContext
                context.delete(store.recipesSelected[currentRow])
                store.recipesSelected.remove(at: currentRow)
                do {
                    try context.save()
                } catch _ { print("Error deleting item.")}
                self.delegate?.updateTableViewNow()
            }
        }
    }
}
