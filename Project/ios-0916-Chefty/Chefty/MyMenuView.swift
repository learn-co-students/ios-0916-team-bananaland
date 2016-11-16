//
//  MyMenuView.swift
//  Chefty
//
//  Created by Paul Tangen on 11/16/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

class MyMenuView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame:CGRect){
        super.init(frame: frame)
        
        // delete appetizer button
        let deleteApp: UIButton = UIButton()
        deleteApp.backgroundColor = UIColor.green
        deleteApp.setTitle("Click Me", for: UIControlState.normal)
        deleteApp.addTarget(self, action: #selector(MyMenuView.deleteAppAction), for: UIControlEvents.touchUpInside)
        self.addSubview(deleteApp)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func deleteAppAction() {
        print("delete action")
    }

}
