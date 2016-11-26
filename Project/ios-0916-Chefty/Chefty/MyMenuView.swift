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


class MyMenuView: UIView, UITableViewDelegate, UITableViewDataSource, MyMenuTableViewCellDelegate, UIPickerViewDelegate {
    
    weak var delegate: MyMenuViewDelegate?
    var sampleValue = String()
    var store = DataStore.sharedInstance
    let tableView = UITableView()
    let toolbar = UIToolbar()
    var recipeForTraditionalRecipeView: Recipe?
    let timePicker1: UIDatePicker = UIDatePicker()
    
    
    
    override init(frame:CGRect){
        super.init(frame: frame)

        // configure controls
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // add the controls to the view
        self.addSubview(tableView)
        self.addSubview(toolbar)
        self.addSubview(self.timePicker1)
        
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
        
        // timepicker
        //self.timePicker1.center = self.center
        self.timePicker1.frame = CGRect(x: 0, y: 50, width: self.frame.width, height: 200)
        self.timePicker1.backgroundColor = UIColor.white
        self.timePicker1.layer.cornerRadius = 5.0
        self.timePicker1.layer.shadowOpacity = 0.5
        //self.timePicker1.layer. = 1000
        self.timePicker1.datePickerMode = .time
        self.timePicker1.addTarget(self, action: #selector(donePickingTimeClick), for: .valueChanged)
    }
    
    func donePickingTimeClick() {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.timeStyle = .medium
        //textField_Date.text = dateFormatter1.stringFromDate(datePicker.date)
        //self.cell.timeButton.resignFirstResponder()
    }
    func cancelClick() {
        //self.cell.timeButton.resignFirstResponder()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.recipesSelected.count
    }
    
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
            
            // set the hour in the icon label
            // get the hour and then use getHourLabel to fetch the constant value for the icon for that hour
            let calendar = Calendar.current
            var hour = calendar.component(.hour, from: servingTime as Date)
            hour > 12 ? hour = hour - 12 : () // convert to 12 time if needed
            cell.hourLabel1.text = getHourLabel(hour: hour)
            
            // set the min in the icon button
            var min = calendar.component(.minute, from: servingTime as Date)
            // We have minute icons for evey 3rd min, so we need to get the minute the user selected and then increase or
            // decrease the value if it not a value divisible by 3. Then use the getMinLabel to fetch the constant value
            // for the icon for that minute
            min % 3 == 1 ? min = min - 1 : ()
            min % 3 == 2 ? min = min + 1 : ()
            cell.timeButton.setTitle(getMinLabel(min: min), for: .normal)
        }

        // cell label: concatenate the type, serving time and recipe label
        var cellLabel = String()
        if let type = store.recipesSelected[indexPath.row].type {
            if let displayName = store.recipesSelected[indexPath.row].displayName {
                cellLabel = "\(type.capitalized) @ \(cellLabelStartTime): \(displayName)"
            }
        }
        cell.cellLabel1.text = cellLabel
        cell.deleteButton.accessibilityLabel = String(indexPath.row)
        cell.timeButton.accessibilityLabel = String(indexPath.row)
        cell.selectionStyle = .none
        Recipe.getBackgroundImage(recipeSelected: self.store.recipesSelected[indexPath.row], imageView: cell.imageView1, view: cell)

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
    
    func getHourLabel(hour: Int) -> Constants.clock.RawValue {
        switch hour {
        case 12:
            return Constants.clock.hr12.rawValue
        case 01:
            return Constants.clock.hr01.rawValue
        case 02:
            return Constants.clock.hr02.rawValue
        case 03:
            return Constants.clock.hr03.rawValue
        case 04:
            return Constants.clock.hr04.rawValue
        case 05:
            return Constants.clock.hr05.rawValue
        case 06:
            return Constants.clock.hr06.rawValue
        case 07:
            return Constants.clock.hr07.rawValue
        case 08:
            return Constants.clock.hr08.rawValue
        case 09:
            return Constants.clock.hr09.rawValue
        case 10:
            return Constants.clock.hr10.rawValue
        case 11:
            return Constants.clock.hr11.rawValue
        default:
            return Constants.clock.hr12.rawValue
        }
    }
    
    func getMinLabel(min: Int) -> Constants.clock.RawValue {
        switch min {
        case 00:
            return Constants.clock.min00.rawValue
        case 03:
            return Constants.clock.min03.rawValue
        case 06:
            return Constants.clock.min06.rawValue
        case 09:
            return Constants.clock.min09.rawValue
        case 12:
            return Constants.clock.min12.rawValue
        case 15:
            return Constants.clock.min15.rawValue
        case 18:
            return Constants.clock.min18.rawValue
        case 21:
            return Constants.clock.min21.rawValue
        case 24:
            return Constants.clock.min24.rawValue
        case 27:
            return Constants.clock.min27.rawValue
        case 30:
            return Constants.clock.min30.rawValue
        case 33:
            return Constants.clock.min33.rawValue
        case 36:
            return Constants.clock.min36.rawValue
        case 39:
            return Constants.clock.min39.rawValue
        case 42:
            return Constants.clock.min42.rawValue
        case 45:
            return Constants.clock.min45.rawValue
        case 48:
            return Constants.clock.min48.rawValue
        case 51:
            return Constants.clock.min51.rawValue
        case 54:
            return Constants.clock.min54.rawValue
        case 57:
            return Constants.clock.min57.rawValue
        default:
            print(min)
            return Constants.clock.min00.rawValue
        }
    }
    
}
