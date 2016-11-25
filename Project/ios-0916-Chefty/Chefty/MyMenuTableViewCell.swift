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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    var cellLabel1:UILabel = UILabel()
    var imageView1:UIImageView = UIImageView()
    let deleteButton: UIButton = UIButton(type: .roundedRect)
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
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
        self.cellLabel1.textColor = UIColor.white
        self.cellLabel1.font =  UIFont(name: Constants.appFont.bold.rawValue, size: CGFloat(Constants.fontSize.medium.rawValue))
        contentView.addSubview(self.cellLabel1)
        self.cellLabel1.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        self.cellLabel1.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        self.cellLabel1.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        self.cellLabel1.translatesAutoresizingMaskIntoConstraints = false
        
        // delete button
        let deleteButton: UIButton = UIButton(type: .roundedRect)
        deleteButton.setTitle(Constants.iconLibrary.close.rawValue, for: .normal)
        deleteButton.titleLabel!.font =  UIFont(name: Constants.iconFont.material.rawValue, size: CGFloat(Constants.iconSize.xsmall.rawValue))
        deleteButton.setTitleColor(UIColor(named: .white), for: .normal)
        deleteButton.addTarget(self, action: #selector(MyMenuTableViewCell.onClickDeleteAction), for: UIControlEvents.touchUpInside)
        contentView.addSubview(deleteButton)
        deleteButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30).isActive = true
        deleteButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        // set time button
        let timeButton: UIButton = UIButton(type: .roundedRect)
        timeButton.setTitle(Constants.iconLibrary.access_time.rawValue, for: .normal)
        timeButton.titleLabel!.font =  UIFont(name: Constants.iconFont.material.rawValue, size: CGFloat(Constants.iconSize.xsmall.rawValue))
        timeButton.setTitleColor(UIColor(named: .white), for: .normal)
        timeButton.addTarget(self, action: #selector(MyMenuTableViewCell.onClickTimeAction), for: UIControlEvents.touchUpInside)
        contentView.addSubview(timeButton)
        timeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        timeButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        timeButton.translatesAutoresizingMaskIntoConstraints = false
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
    
    func onClickTimeAction() {
        if let currentRowString = self.deleteButton.accessibilityLabel {
            if let currentRow = Int(currentRowString) {
                let context = store.persistentContainer.viewContext
                //let currentTime = NSDate()
                //store.recipesSelected[currentRow].servingTime = currentTime
                do {
                    try context.save()
                } catch _ { print("Error setting time on recipeSelected.")}
                
                self.delegate?.updateTableViewNow()
            }
        }
    }
    
    func setTimeAction() {
        print("set time")
    }

}
