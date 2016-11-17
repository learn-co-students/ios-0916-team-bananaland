//
//  HomePageViewController.swift
//  Chefty
//
//  Created by Arvin San Miguel on 11/17/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var collectionView: UICollectionView!
    var recipeImages = [UIImage]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        layoutRecipeCollectionView()
        
    }
    
    
   
    func layoutRecipeView() -> CGRect {
        
        let recipeView = UIView(frame: CGRect(x: view.bounds.minX, y: view.bounds.maxY * 0.25, width: view.bounds.width, height: view.bounds.height))
        recipeView.layer.cornerRadius = 5.0
        recipeView.backgroundColor = UIColor.white
        view.addSubview(recipeView)
        return recipeView.frame
        
    }
    
    func layoutRecipeCollectionView() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: layoutRecipeView(), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "recipeCell")
        self.view.addSubview(collectionView)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipeImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recipeCell", for: indexPath)
        cell.backgroundColor = UIColor.brown
        return cell
    }
   

}
