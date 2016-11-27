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


class MyMenuView: UIView, UITableViewDelegate, UITableViewDataSource, MyMenuTableViewCellDelegate, UIPickerViewDelegate, UITextFieldDelegate {
    
    weak var delegate: MyMenuViewDelegate?
    var sampleValue = String()
    var store = DataStore.sharedInstance
    let tableView = UITableView()
    let toolbar = UIToolbar()
    var recipeForTraditionalRecipeView: Recipe?
    
    var timePicker0: UIDatePicker = UIDatePicker()
    var timePicker1: UIDatePicker = UIDatePicker()
    var timePicker2: UIDatePicker = UIDatePicker()
    var timePicker3: UIDatePicker = UIDatePicker()
    
    var textField0: UITextField = UITextField()
    var textField1: UITextField = UITextField()
    var textField2: UITextField = UITextField()
    var textField3: UITextField = UITextField()
    
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
        
        // timepicker
        self.timePicker0.backgroundColor = UIColor.white
        self.timePicker0.layer.shadowOpacity = 0.5
        self.timePicker0.datePickerMode = .time
        self.timePicker0.minimumDate = Date()
        self.timePicker0.minuteInterval = 15
        
        self.timePicker1.backgroundColor = UIColor.white
        self.timePicker1.layer.shadowOpacity = 0.5
        self.timePicker1.datePickerMode = .time
        self.timePicker1.minimumDate = Date()
        self.timePicker1.minuteInterval = 15
        
        self.timePicker2.backgroundColor = UIColor.white
        self.timePicker2.layer.shadowOpacity = 0.5
        self.timePicker2.datePickerMode = .time
        self.timePicker2.minimumDate = Date()
        self.timePicker2.minuteInterval = 15
        
        self.timePicker3.backgroundColor = UIColor.white
        self.timePicker3.layer.shadowOpacity = 0.5
        self.timePicker3.datePickerMode = .time
        self.timePicker3.minimumDate = Date()
        self.timePicker3.minuteInterval = 15
        
        // toolbar buttons
        let ingredientsButton: UIBarButtonItem = UIBarButtonItem(title: "Ingredients", style: .plain , target: self, action: #selector(clickIngredients))
        let clearAllButton: UIBarButtonItem = UIBarButtonItem(title: "Clear All", style: .plain , target: self, action: #selector(clearAllRecipes))
        let openStep1Button: UIBarButtonItem = UIBarButtonItem(title: "Open Step 1", style: .plain , target: self, action: #selector(openStep1))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let toolbarButtons = [ingredientsButton, spacer, clearAllButton, spacer, openStep1Button]
        self.toolbar.setItems(toolbarButtons, animated: false)
    }
    
    func doneClickTimePicker0() {
        let dateFormatterInst = DateFormatter()
        dateFormatterInst.dateStyle = .none
        dateFormatterInst.timeStyle = .short
        self.textField0.text = dateFormatterInst.string(from: self.timePicker0.date)
        if let cellLabel = self.textField0.text { self.textField0.text = "@ \(cellLabel)" }
        self.textField0.resignFirstResponder()
    }
    
    func doneClickTimePicker1() {
        let dateFormatterInst = DateFormatter()
        dateFormatterInst.dateStyle = .none
        dateFormatterInst.timeStyle = .short
        self.textField1.text = dateFormatterInst.string(from: self.timePicker1.date)
        if let cellLabel = self.textField1.text { self.textField1.text = "@ \(cellLabel)" }
        self.textField1.resignFirstResponder()
    }
    
    func doneClickTimePicker2() {
        let dateFormatterInst = DateFormatter()
        dateFormatterInst.dateStyle = .none
        dateFormatterInst.timeStyle = .short
        self.textField2.text = dateFormatterInst.string(from: self.timePicker2.date)
        if let cellLabel = self.textField2.text { self.textField2.text = "@ \(cellLabel)" }
        self.textField2.resignFirstResponder()
    }
    
    func doneClickTimePicker3() {
        let dateFormatterInst = DateFormatter()
        dateFormatterInst.dateStyle = .none
        dateFormatterInst.timeStyle = .short
        self.textField3.text = dateFormatterInst.string(from: self.timePicker3.date)
        if let cellLabel = self.textField3.text { self.textField3.text = "@ \(cellLabel)" }
        self.textField3.resignFirstResponder()
    }
    
    func cancelClickTimePicker0() { self.textField0.resignFirstResponder() }
    func cancelClickTimePicker1() { self.textField1.resignFirstResponder() }
    func cancelClickTimePicker2() { self.textField2.resignFirstResponder() }
    func cancelClickTimePicker3() { self.textField3.resignFirstResponder() }
    
    func createPickerToolBar0() -> UIToolbar {
        let toolbar0 = UIToolbar()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(self.doneClickTimePicker0))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelClickTimePicker0))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolbar0.sizeToFit()
        toolbar0.setItems([cancelButton, spaceButton, doneButton], animated: false)
        return toolbar0
    }
    
    func createPickerToolBar1() -> UIToolbar {
        let toolbar1 = UIToolbar()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(self.doneClickTimePicker1))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelClickTimePicker1))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolbar1.sizeToFit()
        toolbar1.setItems([cancelButton, spaceButton, doneButton], animated: false)
        return toolbar1
    }
    
    func createPickerToolBar2() -> UIToolbar {
        let toolbar2 = UIToolbar()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(self.doneClickTimePicker2))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelClickTimePicker2))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolbar2.sizeToFit()
        toolbar2.setItems([cancelButton, spaceButton, doneButton], animated: false)
        return toolbar2
    }
    
    func createPickerToolBar3() -> UIToolbar {
        let toolbar3 = UIToolbar()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(self.doneClickTimePicker3))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelClickTimePicker3))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolbar3.sizeToFit()
        toolbar3.setItems([cancelButton, spaceButton, doneButton], animated: false)
        return toolbar3
    }

    // setup tableview
    
    func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return store.recipesSelected.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // set the custom cell
        let cell = MyMenuTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "prototypeCell")
        cell.delegate = self
        
        // format the time
        let myFormatter = DateFormatter()
        myFormatter.timeStyle = .short
        
        var cellLabelStartTime = "?"
        if let servingTime = store.recipesSelected[indexPath.row].servingTime {
            cellLabelStartTime = myFormatter.string(from: servingTime as Date)
        }

        // set displayName and serving time
        if let displayNameUnwrapped = store.recipesSelected[indexPath.row].displayName {
            cell.recipeDescField.text = "\(displayNameUnwrapped)                                  " // extra space pushes label left
        }
        cell.servingTimeField.text = "@ \(cellLabelStartTime)"
        cell.deleteButton.accessibilityLabel = String(indexPath.row)
        cell.selectionStyle = .none
        Recipe.getBackgroundImage(recipeSelected: self.store.recipesSelected[indexPath.row], imageView: cell.imageView1, view: cell)
        cell.servingTimeField.delegate = self
        
        // give the text field in each cell a unique timepicker so the timepicker can return the results to the proper text field
        switch indexPath.row {
        case 1:
            self.textField1 = cell.servingTimeField
            self.textField1.inputView = self.timePicker1
            self.textField1.inputAccessoryView = self.createPickerToolBar1()
        case 2:
            self.textField2 = cell.servingTimeField
            self.textField2.inputView = self.timePicker2
            self.textField2.inputAccessoryView = self.createPickerToolBar2()
        case 3:
            self.textField3 = cell.servingTimeField
            self.textField3.inputView = self.timePicker3
            self.textField3.inputAccessoryView = self.createPickerToolBar3()
        default:
            self.textField0 = cell.servingTimeField
            self.textField0.inputView = self.timePicker0
            self.textField0.inputAccessoryView = self.createPickerToolBar0()
        }
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
    
    func openStep1() {
        print("openStep1 needs a segue")
    }
    
    // given a RecipeSelected, return the the related recipe - we need the related recipe to fetch the images with the function in the Recipe class
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
