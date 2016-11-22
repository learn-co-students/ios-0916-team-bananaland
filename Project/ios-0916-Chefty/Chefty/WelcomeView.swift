//
//  WelcomeView.swift
//  Chefty
//
//  Created by Paul Tangen on 11/22/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

// protocol/delegate needed to segue from our parent view controller to another view controller
protocol WelcomeViewDelegate: class {
    func goToHome()
}

class WelcomeView: UIView {

    weak var delegate:WelcomeViewDelegate!
    let appDesc: UITextView = UITextView()
    
    override init(frame:CGRect){
        super.init(frame: frame)
        
        // initialize button

        let logoImageView = UIImageView()
        logoImageView.image = #imageLiteral(resourceName: "iTunesArtwork.png")     //iTunesArtwork
        logoImageView.contentMode = UIViewContentMode.scaleAspectFit
        
        // configure controls
        appDesc.text = "Receive a set of steps to prepare dinner after choosing several dishes. \n\nStart in 4 seconds."
        appDesc.font =  UIFont(name: Constants.appFont.regular.rawValue, size: CGFloat(Constants.fontSize.xlarge.rawValue))
        //appDesc = UIColor.blue
        appDesc.isScrollEnabled = false
        appDesc.isEditable = false
        appDesc.textContainer.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        // add the object to the view
        self.addSubview(appDesc)
        self.addSubview(logoImageView)
        
        // constrain the object

        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: -80).isActive = true
        logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier:0.6).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        appDesc.translatesAutoresizingMaskIntoConstraints = false
        appDesc.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: -100).isActive = true
        appDesc.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 200).isActive = true
        appDesc.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 50).isActive = true
        appDesc.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -50).isActive = true
        
        self.perform(#selector(self.countDown3), with: nil, afterDelay: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func countDown3(){
        appDesc.text = "Receive a set of steps to prepare dinner after choosing several dishes. \n\nStart in 3 seconds."
        self.perform(#selector(self.countDown2), with: nil, afterDelay: 1)
    }
    
    func countDown2(){
        appDesc.text = "Receive a set of steps to prepare dinner after choosing several dishes. \n\nStart in 2 seconds."
        self.perform(#selector(self.countDown1), with: nil, afterDelay: 1)
    }
    
    func countDown1(){
        appDesc.text = "Receive a set of steps to prepare dinner after choosing several dishes. \n\nStart in 1 seconds."
        self.perform(#selector(showHome), with: nil, afterDelay: 1)
    }
    
    func showHome(){
        self.delegate.goToHome()
    }

}
