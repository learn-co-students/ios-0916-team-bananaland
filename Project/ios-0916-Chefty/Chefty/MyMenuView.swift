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
    func goToSingleStep()
}

class MyMenuView: UIView, UITableViewDelegate, UITableViewDataSource, MyMenuTableViewCellDelegate, UIPickerViewDelegate, UITextFieldDelegate {
    
    weak var delegate: MyMenuViewDelegate?
    var sampleValue = String()
    var store = DataStore.sharedInstance
    let tableView = UITableView()
    let toolbar = UIToolbar()
    var recipeForTraditionalRecipeView: Recipe?
    var textFieldBeingEdited: UITextField = UITextField()
    
    // TRY: date picker with constraints
    let datePickerContainerView = UIView()
    var datePickerContainerViewOffScreenConstraint = NSLayoutConstraint()
    var datePickerContainerViewOnScreenConstraint = NSLayoutConstraint()
    let datePicker = UIDatePicker()
    
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
        
        // tableview
        self.tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: toolbar.topAnchor, constant: 0).isActive = true
        self.tableView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        // toolbar buttons
        let ingredientsButton: UIBarButtonItem = UIBarButtonItem(title: "Ingredients", style: .plain , target: self, action: #selector(clickIngredients))
        let clearAllButton: UIBarButtonItem = UIBarButtonItem(title: "Clear All", style: .plain , target: self, action: #selector(clearAllRecipes))
        let openStep1Button: UIBarButtonItem = UIBarButtonItem(title: "Open Step \(store.stepCurrent)", style: .plain , target: self, action: #selector(clickOpenStep))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let toolbarButtons = [ingredientsButton, spacer, clearAllButton, spacer, openStep1Button]
        self.toolbar.setItems(toolbarButtons, animated: false)
        
        // define the timePicker container view
        self.addSubview(datePickerContainerView)
        datePickerContainerView.translatesAutoresizingMaskIntoConstraints = false
        datePickerContainerView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        datePickerContainerView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.33).isActive = true
        datePickerContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        datePickerContainerViewOffScreenConstraint = datePickerContainerView.topAnchor.constraint(equalTo: self.bottomAnchor)
        datePickerContainerViewOffScreenConstraint.isActive = true
        datePickerContainerViewOnScreenConstraint = datePickerContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        datePickerContainerViewOnScreenConstraint.isActive = false
        
        // create the done/cancel toolbar for the time picker
        let pickerToolbar = UIToolbar()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(self.doneClickTimePicker))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelClickTimePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        pickerToolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        datePickerContainerView.addSubview(pickerToolbar)
        pickerToolbar.translatesAutoresizingMaskIntoConstraints = false
        pickerToolbar.leadingAnchor.constraint(equalTo: datePickerContainerView.leadingAnchor).isActive = true
        pickerToolbar.topAnchor.constraint(equalTo: datePickerContainerView.topAnchor).isActive = true
        pickerToolbar.widthAnchor.constraint(equalTo: datePickerContainerView.widthAnchor).isActive = true
        pickerToolbar.heightAnchor.constraint(equalTo: datePickerContainerView.heightAnchor, multiplier: 0.2).isActive = true
        datePickerContainerView.addSubview(pickerToolbar)
        
        // define datePicker
        datePicker.backgroundColor = UIColor.white
        datePicker.layer.shadowOpacity = 0.5
        datePicker.datePickerMode = .time
        datePicker.minimumDate = Date()
        datePicker.minuteInterval = 15
        datePickerContainerView.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.leadingAnchor.constraint(equalTo: datePickerContainerView.leadingAnchor).isActive = true
        datePicker.topAnchor.constraint(equalTo: pickerToolbar.bottomAnchor).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: datePickerContainerView.bottomAnchor).isActive = true
        datePicker.widthAnchor.constraint(equalTo: datePickerContainerView.widthAnchor).isActive = true
    }
    
    func doneClickTimePicker() {
        // save new serving time to core data
        store.recipesSelected[0].servingTime = self.datePicker.date as NSDate?
        self.store.saveRecipeSelectedContext()
        // update field
        let dateFormatterInst = DateFormatter()
        dateFormatterInst.dateStyle = .none
        dateFormatterInst.timeStyle = .short
        self.textFieldBeingEdited.text = dateFormatterInst.string(from: self.datePicker.date)
        if let cellLabel = self.textFieldBeingEdited.text { self.textFieldBeingEdited.text = "@ \(cellLabel)" }
        self.textFieldBeingEdited.resignFirstResponder()
        // hide the time picker
        UIView.animate(withDuration: 0.3, animations: {
            
            self.datePickerContainerViewOffScreenConstraint.isActive = true
            self.datePickerContainerViewOnScreenConstraint.isActive = false
            self.layoutIfNeeded()
            
        })
    }
    
    func cancelClickTimePicker() {
        self.textFieldBeingEdited.resignFirstResponder()
        // hide the time picker
        UIView.animate(withDuration: 0.3, animations: {
            
            self.datePickerContainerViewOffScreenConstraint.isActive = true
            self.datePickerContainerViewOnScreenConstraint.isActive = false
            self.layoutIfNeeded()
            
        })
    }

    // setup tableview
    func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return store.recipesSelected.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // set the custom cell
        let cell = MyMenuTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "prototypeCell")
        cell.delegate = self
        cell.recipeSelected = store.recipesSelected[indexPath.row]
        cell.deleteButton.accessibilityLabel = String(indexPath.row)
        cell.selectionStyle = .none
        Recipe.getBackgroundImage(recipeSelected: self.store.recipesSelected[indexPath.row], imageView: cell.imageViewInst, view: cell)
        return cell
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
    
    func updateTableViewNow() { self.tableView.reloadData() }
    
    // serving time field selected delegate method
    func servingTimeFieldSelected(_ sender: UITextField) {
        
        self.textFieldBeingEdited = sender
        
        sender.isUserInteractionEnabled = false
        
        // present date picker
        UIView.animate(withDuration: 0.3, animations: {
            
            self.datePickerContainerViewOffScreenConstraint.isActive = false
            self.datePickerContainerViewOnScreenConstraint.isActive = true
            self.layoutIfNeeded()
        
        })
    }
    
    func clickIngredients() { self.delegate?.goToIngredients() }
    
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
    
    func clickOpenStep() {
        self.delegate?.goToSingleStep()
    }
    
    // given a RecipeSelected, return the the related recipe - 
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
