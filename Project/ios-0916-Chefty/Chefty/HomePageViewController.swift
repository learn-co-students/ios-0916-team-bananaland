//
//  HomePageViewController.swift
//  Chefty
//
//  Created by Arvin San Miguel on 11/17/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController {
    
    var scrollView: UIScrollView!
    var store = DataStore.sharedInstance
    
    var recipeImages = [#imageLiteral(resourceName: "moroccanChicken"), #imageLiteral(resourceName: "dijonChickenBreasts"), #imageLiteral(resourceName: "sweetPotatoFries"), #imageLiteral(resourceName: "beefBroccoliStirFry"), #imageLiteral(resourceName: "peachCobbler"),
                        #imageLiteral(resourceName: "snickerdoodleCookies"),#imageLiteral(resourceName: "applePie"), #imageLiteral(resourceName: "BarbequedDeviledEggs"), #imageLiteral(resourceName: "AuthenticItalianMeatballs"), #imageLiteral(resourceName: "marinatedCheeseAppetizer"), #imageLiteral(resourceName: "choppedSaladAppetizerShells"), #imageLiteral(resourceName: "balsamicBrusselSprouts"), #imageLiteral(resourceName: "blackBeanCouscousSalad"), #imageLiteral(resourceName: "RoastedGreenBeans"), #imageLiteral(resourceName: "yummyBakedPotatoSkins"), #imageLiteral(resourceName: "marinatedCheeseAppetizer")]
    
    var recipeName = ["Moroccan Chicken", "Dijon Chicken Breasts", "Sweet Potato Fries", "Beef Broccoli Stir Fry", "Peach Cobbler",
                      "Snicker Doodle Cookies", "Apple Pie", "Barbequed Devil Eggs", "Authentic Italian Meatballs", "Marinated Cheese Appetizer", "Chopped Salad Appetizer Shells", "Balsamic Brussel Sprouts", "Black Bean Couscous Salad", "Roasted Green Beans", "Yummy Baked Potato Skins", "Marinated Cheese Appetizer"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        store.getRecipes(completion: { _ in print(self.store.recipes.count) })
        setupScrollView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupRecipeCollectionViews()
    }
    
}

extension HomePageViewController : UICollectionViewDelegate, UICollectionViewDataSource  {
    
    func setupScrollView() {
        
        let frame = CGRect(x: view.bounds.minX, y: view.bounds.maxY * 0.25, width: view.bounds.width, height: view.bounds.height * 0.75)
        scrollView = UIScrollView(frame: frame)
        scrollView.isScrollEnabled = true
        scrollView.isPagingEnabled = true
        scrollView.backgroundColor = UIColor.white
        view.addSubview(scrollView)
        
    }
    
    func setupRecipeCollectionViews() {
        
        for i in 0...3 {
            
            let xPos = self.scrollView.frame.width * CGFloat(i)
            let frame = CGRect(x: xPos, y: 0.0, width: self.scrollView.frame.width, height: self.scrollView.frame.height)
            let layout : UICollectionViewLayout = CustomLayoutView()
            let view = UICollectionView(frame: frame, collectionViewLayout: layout)
            view.register(RecipeCollectionViewCell.self, forCellWithReuseIdentifier: "recipeCell")
            view.delegate = self
            view.dataSource = self
            view.backgroundColor = UIColor.white
            scrollView.contentSize.width = scrollView.frame.width * CGFloat(i + 1)
            scrollView.addSubview(view)
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipeImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recipeCell", for: indexPath) as! RecipeCollectionViewCell
        cell.imageView.image = recipeImages[indexPath.row]
        cell.recipeLabel.text = recipeName[indexPath.row]
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
