//
//  TestMenuTableViewCell.swift
//  Chefty
//
//  Created by Arvin San Miguel on 11/30/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

class TestMenuTableViewCell: UITableViewCell {
 
    var recipeLabel: UILabel!
    var recipe : Recipe?
    var selectedRecipeImage: UIImageView!
    let deleteButton: UIButton = UIButton(type: .roundedRect)
    
    var store = DataStore.sharedInstance
    weak var delegate: MyMenuTableViewCellDelegate?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        commonInit()
        
    }
    
    
    private func commonInit() {
        
        selectedRecipeImage = UIImageView()
        selectedRecipeImage.contentMode = .scaleAspectFill
        contentView.addSubview(selectedRecipeImage)
        selectedRecipeImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        selectedRecipeImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        selectedRecipeImage.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        selectedRecipeImage.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        selectedRecipeImage.translatesAutoresizingMaskIntoConstraints = false
        
        deleteButton.setTitle(Constants.iconLibrary.close.rawValue, for: .normal)
        deleteButton.titleLabel!.font =  UIFont(name: Constants.iconFont.material.rawValue, size: CGFloat(Constants.iconSize.xsmall.rawValue))
        deleteButton.setTitleColor(UIColor(named: .white), for: .normal)
        deleteButton.addTarget(self, action: #selector(MyMenuTableViewCell.onClickDeleteAction), for: UIControlEvents.touchUpInside)
        contentView.addSubview(deleteButton)
        deleteButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        deleteButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    // should begin editing textfield delegate method
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.delegate?.servingTimeFieldSelected(textField)
        return false // prevents field from being editable
    }
    
    func onClickDeleteAction() {
        if let currentRowString = self.deleteButton.accessibilityLabel {
            if let currentRow = Int(currentRowString) {
                store.setRecipeUnselected(recipe: store.recipesSelected[currentRow])
                self.delegate?.updateTableViewNow()
            }
        }
    }
    
    
    
    
}
