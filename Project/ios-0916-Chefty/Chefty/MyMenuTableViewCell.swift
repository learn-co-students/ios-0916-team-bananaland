//
//  MyMenuTableViewCell.swift
//  Chefty
//
//  Created by Paul Tangen on 11/19/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

class MyMenuTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var myLabel1: UILabel!
    var myLabel2: UILabel!
    var myButton1 : UIButton!
    var myButton2 : UIButton!
    let imageView1 = UIImageView(frame: CGRect(x:0, y:0, width:200, height:85))
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let gap : CGFloat = 10
        let labelHeight: CGFloat = 30
        let labelWidth: CGFloat = 150
        let lineGap : CGFloat = 5
        let label2Y : CGFloat = gap + labelHeight + lineGap
        let imageSize : CGFloat = 30
        
        contentView.addSubview(imageView1)
        imageView1.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView1.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        imageView1.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        imageView1.translatesAutoresizingMaskIntoConstraints = false
        //self.sendSubview(toBack: imageView1)
        //imageView1.layer.zPosition = 0
        
        myLabel1 = UILabel()
        myLabel1.frame = CGRect(x: gap, y: gap, width: labelWidth, height: labelHeight)
        myLabel1.textColor = UIColor.black
        contentView.addSubview(myLabel1)
        myLabel1.layer.zPosition = 1
        
        myLabel2 = UILabel()
        myLabel2.frame = CGRect(x:gap, y:label2Y, width:labelWidth, height:labelHeight)
        myLabel2.textColor = UIColor.black
        contentView.addSubview(myLabel2)
        //myLabel2.layer.zPosition = 1
        
        
        let deleteButton: UIButton = UIButton(type: .roundedRect)
        deleteButton.setTitle(Constants.iconLibrary.close.rawValue, for: .normal)
        deleteButton.titleLabel!.font =  UIFont(name: Constants.iconFont.material.rawValue, size: CGFloat(Constants.iconSize.small.rawValue))
        deleteButton.setTitleColor(UIColor(named: .red), for: .normal)
        deleteButton.addTarget(self, action: #selector(MyMenuTableViewCell.deleteAction), for: UIControlEvents.touchUpInside)
        contentView.addSubview(deleteButton)
        deleteButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        deleteButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        myButton2 = UIButton()
        myButton2.frame = CGRect(x:bounds.width-imageSize - gap, y:label2Y, width:imageSize, height:imageSize)
        myButton2.setImage(UIImage(named: "telephone.png"), for: UIControlState.normal)
        contentView.addSubview(myButton2)
    }
    
    func deleteAction() {
        print("delete item")
    }

}
