//
//  MyMenuView.swift
//  Chefty
//
//  Created by Paul Tangen on 11/16/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

class MyMenuView: UIView {
    
    override init(frame:CGRect){
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.gray
        
        // delete appetizer button - initialize
        let deleteApp: UIButton = UIButton(type: .roundedRect)
        
        // configure the button
        deleteApp.setTitle(Constants.iconLibrary.close.rawValue, for: .normal)
        deleteApp.addTarget(self, action: #selector(MyMenuView.deleteAppAction), for: UIControlEvents.touchUpInside)
        deleteApp.titleLabel!.font =  UIFont(name: Constants.iconFont.material.rawValue, size: CGFloat(Constants.iconSize.large.rawValue))
        deleteApp.setTitleColor(UIColor(named: .blue), for: .normal)
        
        // add the button
        self.addSubview(deleteApp)
        
        // constrain the button
        deleteApp.topAnchor.constraint(equalTo: self.topAnchor, constant: 100).isActive = true
        deleteApp.translatesAutoresizingMaskIntoConstraints = false

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func deleteAppAction() {
        print("delete app")
    }

}
