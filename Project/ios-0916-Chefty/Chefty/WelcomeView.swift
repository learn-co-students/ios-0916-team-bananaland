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
    func goToMyMenu()
}

class WelcomeView: UIView {
    
    let store = DataStore.sharedInstance

    weak var delegate:WelcomeViewDelegate!
    let appDesc: UITextView = UITextView()
    var messageTimerLabel: UILabel = UILabel()
    var descriptionOfState = String()
    var messageTimer = String()
    
    override init(frame:CGRect){
        super.init(frame: frame)
        
        // if the user selected a recipe, show My Menu. If no recipe is selected, show the Home page. If they are on a step, take them to that step.
        if store.recipesSelected.count == 0 {
            self.descriptionOfState = "Receive the steps to prepare dinner after choosing several dishes."
        } else if store.recipesSelected.count == 1 {
            self.descriptionOfState = "Last time you were here, you selected one recipe, lets review it."
        } else if store.recipesSelected.count > 1 {
            self.descriptionOfState = "Last time you were here, you selected \(store.recipesSelected.count) recipes, lets review them."
        }
        
        self.messageTimer = "Start in 4 seconds."
        
        // initialize button
        let logoImageView = UIImageView()
        logoImageView.image = #imageLiteral(resourceName: "iTunesArtwork.png")     //iTunesArtwork
        logoImageView.contentMode = UIViewContentMode.scaleAspectFit
        
        // configure controls
        appDesc.text = descriptionOfState
        appDesc.font =  UIFont(name: Constants.appFont.regular.rawValue, size: CGFloat(Constants.fontSize.large.rawValue))
        appDesc.isScrollEnabled = false
        appDesc.isEditable = false
        appDesc.textContainer.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        messageTimerLabel.text = messageTimer
        messageTimerLabel.font =  UIFont(name: Constants.appFont.regular.rawValue, size: CGFloat(Constants.fontSize.large.rawValue))
        
        // add the object to the view
        self.addSubview(appDesc)
        self.addSubview(messageTimerLabel)
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

        messageTimerLabel.translatesAutoresizingMaskIntoConstraints = false
        messageTimerLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 160).isActive = true
        messageTimerLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 50).isActive = true
        messageTimerLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -50).isActive = true
        
        self.perform(#selector(self.countDown3), with: nil, afterDelay: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func countDown3(){
        self.messageTimer = "Start in 3 seconds."
        messageTimerLabel.text = self.messageTimer
        self.perform(#selector(self.countDown2), with: nil, afterDelay: 1)
    }
    
    func countDown2(){
        self.messageTimer = "Start in 2 seconds."
        messageTimerLabel.text = self.messageTimer
        self.perform(#selector(self.countDown1), with: nil, afterDelay: 1)
    }
    
    func countDown1(){
        self.messageTimer = "Start in 1 second."
        messageTimerLabel.text = self.messageTimer
        self.perform(#selector(showMyMenu), with: nil, afterDelay: 1)
    }
    
    func showHome(){
        self.delegate.goToHome()
    }
    
    func showMyMenu(){
        self.delegate.goToMyMenu()
    }

}
