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
        
        self.backgroundColor = UIColor.white
        
        // delete appetizer button - initialize
        let deleteApp: UIButton = UIButton(type: .roundedRect)
        
        // configure the button
        deleteApp.setTitle(Constants.iconLibrary.close.rawValue, for: .normal)
        deleteApp.titleLabel!.font =  UIFont(name: Constants.iconFont.material.rawValue, size: CGFloat(Constants.iconSize.medium.rawValue))
        deleteApp.setTitleColor(UIColor(named: .red), for: .normal)
        deleteApp.addTarget(self, action: #selector(MyMenuView.deleteAppAction), for: UIControlEvents.touchUpInside)
        
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
