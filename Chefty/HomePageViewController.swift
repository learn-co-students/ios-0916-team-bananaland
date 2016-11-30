//
//  HomePageViewController.swift
//  Chefty
//
//  Created by Arvin San Miguel on 11/17/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController, UIScrollViewDelegate {
    
    var recipeScrollView: UIScrollView!
    var store = DataStore.sharedInstance
    var currentPage: Int { return Int(self.recipeScrollView.contentOffset.x / self.recipeScrollView.frame.width ) }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupScrollView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupRecipeCollectionViews()
        recipeScrollView.reloadInputViews()
    }
    
}

extension HomePageViewController : UICollectionViewDelegate, UICollectionViewDataSource  {
    

    func setupScrollView() {
        
        let frame = CGRect(x: view.bounds.minX, y: view.bounds.maxY * 0.25, width: view.bounds.width, height: view.bounds.height * 0.75)
        recipeScrollView = UIScrollView(frame: frame)
        recipeScrollView.isScrollEnabled = true
        recipeScrollView.isPagingEnabled = true
        recipeScrollView.backgroundColor = UIColor.white
        view.addSubview(recipeScrollView)
        
    }
    
    func setupRecipeCollectionViews() {
        
        for i in 0...3 {
            
            let xPos = self.recipeScrollView.frame.width * CGFloat(i)
            let frame = CGRect(x: xPos, y: 0.0, width: self.recipeScrollView.frame.width, height: self.recipeScrollView.frame.height)
            let layout : UICollectionViewLayout = CustomLayoutView()
            let view = UICollectionView(frame: frame, collectionViewLayout: layout)
            view.register(RecipeCollectionViewCell.self, forCellWithReuseIdentifier: "recipeCell")
            view.delegate = self
            view.dataSource = self
            view.backgroundColor = UIColor.white
            recipeScrollView.contentSize.width = recipeScrollView.frame.width * CGFloat(i + 1)
            recipeScrollView.addSubview(view)
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return store.recipes.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recipeCell", for: indexPath) as! RecipeCollectionViewCell
        let url = URL(string: store.recipes[indexPath.row].imageURL!)
        cell.recipeLabel.text = store.recipes[indexPath.row].displayName
        cell.imageView.sd_setImage(with: url!)
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
