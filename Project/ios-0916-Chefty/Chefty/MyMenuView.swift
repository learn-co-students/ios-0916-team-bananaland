//
//  MyMenuView.swift
//  Chefty
//
//  Created by Paul Tangen on 11/16/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit
import CoreData

protocol MyMenuViewDelegate: class {
    func goToRecipe()
    func goToIngredients()
}


class MyMenuView: UIView, UITableViewDelegate, UITableViewDataSource, MyMenuTableViewCellDelegate {
    
    weak var delegate: MyMenuViewDelegate?
    var sampleValue = String()
    var store = DataStore.sharedInstance
    let tableView = UITableView()
    let toolbar = UIToolbar()
    var recipeForTraditionalRecipeView: Recipe?
    
    override init(frame:CGRect){
        super.init(frame: frame)
        
        // configure controls
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // add the controls to the view
        self.addSubview(tableView)
        self.addSubview(toolbar)
        
        // constrain the controls
        self.toolbar.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.toolbar.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.toolbar.translatesAutoresizingMaskIntoConstraints = false
        
        // toolbar buttons
        let ingredientsButton: UIBarButtonItem = UIBarButtonItem(title: "Ingredients", style: .plain , target: self, action: #selector(clickIngredients))
        let clearAllButton: UIBarButtonItem = UIBarButtonItem(title: "Clear All", style: .plain , target: self, action: #selector(clearAllRecipes))
        let openStep1Button: UIBarButtonItem = UIBarButtonItem(title: "Open Step 1", style: .plain , target: self, action: #selector(openStep1))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        let toolbarButtons = [ingredientsButton, spacer, clearAllButton, spacer, openStep1Button]
        self.toolbar.setItems(toolbarButtons, animated: false)
        
        // tableview
        self.tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -44).isActive = true
        self.tableView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.tableView.translatesAutoresizingMaskIntoConstraints = false

    }
    
    func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return store.recipesSelected.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // set the custom cell
        let cell = MyMenuTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "prototypeCell")
        cell.delegate = self
        var myImageView: UIImageView?
        
        // format the time
        let myFormatter = DateFormatter()
        myFormatter.timeStyle = .short
        
        var cellLabelStartTime = "?"
        if let servingTime = store.recipesSelected[indexPath.row].servingTime {
            cellLabelStartTime = myFormatter.string(from: servingTime as Date)
        }

        var cellLabel = String()
        if let type = store.recipesSelected[indexPath.row].type {
            if let displayName = store.recipesSelected[indexPath.row].displayName {
                cellLabel = "\(type.capitalized) @ \(cellLabelStartTime): \(displayName)"
            }
        }
        cell.cellLabel1.text = cellLabel
        cell.deleteButton.accessibilityLabel = String(indexPath.row)
        cell.selectionStyle = .none
        
        let url = URL(string: store.recipesSelected[indexPath.row].imageURL!)
        
//        print("Hello")
//        
//        if let myImageViewUnWrapped = myImageView {
//        
//        myImageViewUnWrapped.sd_setImage(with: url!, completed: { (image, error , cacheType , imageURL) in
//            print(imageURL)
//            self.printMe()
//            //cell.imageView1.image = self.cropToBounds(image: (myImageView?.image!)!, width: 100, height: 300)
//            cell.imageView1.image = image
//        }
//        )
//        }
        
        cell.imageView1.sd_setImage(with: url!)
        
//        if let myImageViewUnwrapped = myImageView {
//            self.printMe()
//            cell.imageView1.image = cropToBounds(image: myImageViewUnwrapped.image!, width: 100, height: 300)
//        }
        
       
        //cell.imageView1.clipsToBounds = true
        //cell.imageView1.contentMode = UIViewContentMode.scaleAspectFit
        return cell
    }
    
    func printMe(){
        print("printMe")
    }
    
    func cropToBounds(image: UIImage, width: Double, height: Double) -> UIImage {
        
        print("in crop to bounds")
        
        let contextImage: UIImage = UIImage(cgImage: image.cgImage!)
        
        let contextSize: CGSize = contextImage.size
        
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = CGFloat(width)
        var cgheight: CGFloat = CGFloat(height)
        
        // See what size is longer and create the center off of that
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            cgwidth = contextSize.height
            cgheight = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            cgwidth = contextSize.width
            cgheight = contextSize.width
        }
        
        let rect: CGRect = CGRect(x:posX, y:posY, width:cgwidth, height:cgheight)
        
        // Create bitmap image from context using the rect
        let imageRef: CGImage = contextImage.cgImage!.cropping(to: rect)!
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
        
        return image
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // the tableview cells are divided up to always fill the page
        let rowHeight = (tableView.bounds.height-60)/CGFloat(store.recipesSelected.count)
        return rowHeight
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // onClick table cell go to recipe
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        self.recipeForTraditionalRecipeView = getRelatedRecipe(recipeSelected: store.recipesSelected[indexPath.row])
        self.delegate?.goToRecipe()
    }
    
    func updateTableViewNow() {
        self.tableView.reloadData()
    }
    
    func clickIngredients() {
        self.delegate?.goToIngredients()
    }
    
    func clearAllRecipes() {
        let context = store.persistentContainer.viewContext
        for _ in store.recipesSelected {
            context.delete(store.recipesSelected[0])
            store.recipesSelected.remove(at: 0)
        }
        do {
            try context.save()
        } catch _ { print("Error deleting item.")}
        self.tableView.reloadData()
    }
    
    func openStep1() {
        print("openStep1 needs a segue")
    }
    
    // given a RecipeSelected, return the the related recipe - we need the related to fetch the images with the function in the Recipe class
    func getRelatedRecipe(recipeSelected: RecipeSelected) -> Recipe {
        var results = store.recipes[0]
        for recipe in store.recipes {
            if recipe.id == recipeSelected.id {
                results = recipe
                break;
            }
        }
        return results
    }
    
}
