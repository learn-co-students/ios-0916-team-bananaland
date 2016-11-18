//
//  HomePageViewController.swift
//  Chefty
//
//  Created by Arvin San Miguel on 11/17/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var collectionView: UICollectionView!
    var recipeImages = [#imageLiteral(resourceName: "moroccanChicken"), #imageLiteral(resourceName: "dijonChickenBreasts"), #imageLiteral(resourceName: "sweetPotatoFries"), #imageLiteral(resourceName: "beefBroccoliStirFry"), #imageLiteral(resourceName: "peachCobbler"),
                        #imageLiteral(resourceName: "snickerdoodleCookies"),#imageLiteral(resourceName: "applePie"), #imageLiteral(resourceName: "BarbequedDeviledEggs"), #imageLiteral(resourceName: "AuthenticItalianMeatballs"), #imageLiteral(resourceName: "marinatedCheeseAppetizer"), #imageLiteral(resourceName: "choppedSaladAppetizerShells"), #imageLiteral(resourceName: "balsamicBrusselSprouts"), #imageLiteral(resourceName: "blackBeanCouscousSalad"), #imageLiteral(resourceName: "RoastedGreenBeans"), #imageLiteral(resourceName: "yummyBakedPotatoSkins")]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        layoutRecipeCollectionView()
        collectionView.reloadData()
    }
    
    
    func layoutRecipeCollectionView() {
        let frame = CGRect(x: view.bounds.minX, y: view.bounds.maxY * 0.25, width: view.bounds.width, height: view.bounds.height * 0.75)
        let layout: UICollectionViewLayout = CustomLayoutView()
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(recipeCollectionViewCell.self, forCellWithReuseIdentifier: "recipeCell")
        view.addSubview(collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipeImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recipeCell", for: indexPath) as! recipeCollectionViewCell
        cell.imageView.image = recipeImages[indexPath.row]
        return cell
    }
    
     func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let interval = Double(indexPath.row)
        
        if (collectionView.frame.intersects(cell.frame)) {
            cell.alpha = 0.0
            cell.center.y = cell.center.y - 30
            
            UIView.animate(withDuration: 0.7 + (interval * 0.05), animations: {
                cell.alpha = 1.0
                cell.center.y += 30
            })
        }
        
        cell.alpha = 0.0
        cell.center.y = cell.center.y + 20
        
        UIView.animate(withDuration: 0.6 + (interval * 0.05), animations: {
            cell.alpha = 1.0
            cell.center.y -= 20
        })
        
    }
   
    

}
