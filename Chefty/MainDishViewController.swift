//
//  MainDishViewController.swift
//  Chefty
//
//  Created by Arvin San Miguel on 11/22/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

class MainDishViewController: UIViewController, RecipeViewDelegate {

    var store = DataStore.sharedInstance
    var collectionView : UICollectionView!
    var selectedRecipe : Recipe?
    var selectedRecipeStatus = false
    let recipeView = TraditionalRecipeViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeView.delegate = self
        setupCollectionView()
        print("MAIN \(store.main.count)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        collectionView.reloadData()
        
    }

}

extension MainDishViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func recipeSelected(_ recipe: Recipe, status: Bool) {
        selectedRecipe = recipe
        selectedRecipeStatus = status
    }
    
    func setupCollectionView() {
        let layout = CustomLayoutView()
        let frame = CGRect(x: view.bounds.minX, y: view.bounds.minY, width: view.bounds.width, height: view.bounds.height * 0.80)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.register(RecipeCollectionViewCell.self, forCellWithReuseIdentifier: "recipeCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        view.addSubview(collectionView)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return store.main.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recipeCell", for: indexPath) as! RecipeCollectionViewCell
        let url = URL(string: store.main[indexPath.row].imageURL!)
        cell.recipe = store.main[indexPath.row]
        cell.recipeLabel.text = store.main[indexPath.row].displayName
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        recipeView.modalTransitionStyle = .crossDissolve
        recipeView.recipe = store.main[indexPath.row]
        present(recipeView, animated: true, completion: nil)
                
    }
    
}
