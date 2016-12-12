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
    func clearAllRecipes()
}

class MyMenuView: UIView, UITableViewDelegate, UITableViewDataSource, MyMenuTableViewCellDelegate, UIPickerViewDelegate, UITextFieldDelegate {
    
    //Define Variables
    weak var delegate: MyMenuViewDelegate?
    var sampleValue = String()
    var store = DataStore.sharedInstance
    let tableView = UITableView()
    let toolbar = UIToolbar()
    var recipeForTraditionalRecipeView: Recipe?
    var textFieldBeingEdited: UITextField = UITextField()
    var timePicker: UIDatePicker = UIDatePicker()
    
    let datePickerContainerView = UIView()
    let servingTimeView = UIView()
    var datePickerContainerViewOffScreenConstraint = NSLayoutConstraint()
    var datePickerContainerViewOnScreenConstraint = NSLayoutConstraint()
    let datePicker = UIDatePicker()
    var servingTimeFieldLabel: UILabel = UILabel()
    var servingTimeField: UITextField = UITextField()
    var servingTimeValue: String = String()
    var startCookingTimeValue: String = String()
    var startCookingTimeField: UITextField = UITextField()

    let ingredientsButton: UIBarButtonItem = UIBarButtonItem(title: "Ingredients", style: .plain , target: self, action: #selector(clickIngredients))
    let clearAllButton: UIBarButtonItem = UIBarButtonItem(title: "Clear All", style: .plain , target: self, action: #selector(onClickClearAllRecipes))
    var openSingleStepButton: UIBarButtonItem = UIBarButtonItem(title: "Open Step", style: .plain , target: self, action: #selector(clickOpenStep))
    
    //Initialize
    override init(frame:CGRect){
        super.init(frame: frame)
        
        if self.store.mergedStepsArray.isEmpty {
            
            store.getStepsFromRecipesSelected {
                
                self.store.mergeRecipeSteps()
                
                for step in self.store.recipeSteps {
                    self.store.mergedStepsArray.append(step)
                }
            }
        }

        store.calculateStartTime()
        
        // format the time
        let myFormatter = DateFormatter()
        myFormatter.timeStyle = .short
        
        // set serving time to 7pm or earliest serving time, whichever is later
        if let recipeSelected = store.recipesSelected.first {
            if (recipeSelected.servingTime?.timeIntervalSince1970)! < store.earliestPossibleServeTime.timeIntervalSince1970 && UserDefaults.standard.integer(forKey: "stepCurrent") == 0 {
                
                for recipeSelected2 in store.recipesSelected {
                    recipeSelected2.servingTime = store.earliestPossibleServeTime as NSDate?
                    store.saveRecipesContext()
                }
            }
            self.servingTimeValue = myFormatter.string(from: recipeSelected.servingTime as! Date)
            self.servingTimeValue = "Serving Time: " + self.servingTimeValue
        }
        
        // configure controls
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // add the controls to the view
        self.addSubview(tableView)
        self.addSubview(toolbar)
        self.addSubview(servingTimeView)
        
        // constrain the controls
        self.toolbar.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.toolbar.barTintColor = UIColor(named: UIColor.ColorName(rawValue: UIColor.ColorName.headingbackground.rawValue)!)
        self.toolbar.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.toolbar.translatesAutoresizingMaskIntoConstraints = false
        
        // servingtime view
        self.servingTimeView.topAnchor.constraint(equalTo: self.topAnchor, constant: 64).isActive = true
        self.servingTimeView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.servingTimeView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.servingTimeView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        self.servingTimeView.translatesAutoresizingMaskIntoConstraints = false
        self.servingTimeView.backgroundColor = UIColor(named: UIColor.ColorName(rawValue: UIColor.ColorName.deepPurple.rawValue)!)
        
        // define servingTimeView
        self.servingTimeField.font = UIFont(name: Constants.appFont.regular.rawValue, size: CGFloat(Constants.fontSize.xsmall.rawValue))
        self.servingTimeField.textColor = self.tintColor
        self.servingTimeView.addSubview(self.servingTimeField)
        self.servingTimeField.text = self.servingTimeValue
        self.servingTimeField.centerYAnchor.constraint(equalTo: self.servingTimeView.centerYAnchor).isActive = true
        self.servingTimeField.leftAnchor.constraint(equalTo: self.servingTimeView.centerXAnchor).isActive = true
        self.servingTimeField.rightAnchor.constraint(equalTo: self.servingTimeView.rightAnchor, constant: -16).isActive = true
        self.servingTimeField.topAnchor.constraint(equalTo: self.servingTimeView.topAnchor).isActive = true
        self.servingTimeField.translatesAutoresizingMaskIntoConstraints = false
        
        self.servingTimeField.inputView = self.timePicker
        self.servingTimeField.inputAccessoryView = self.createPickerToolBar()
        self.servingTimeField.textAlignment = .right
        
        // define startCookingTime
        self.startCookingTimeField.font = UIFont(name: Constants.appFont.regular.rawValue, size: CGFloat(Constants.fontSize.xsmall.rawValue))
        self.startCookingTimeField.textColor = UIColor(named: UIColor.ColorName(rawValue: UIColor.ColorName.beige.rawValue)!)
        self.startCookingTimeField.isUserInteractionEnabled = false
        self.servingTimeView.addSubview(self.startCookingTimeField)
        self.startCookingTimeField.text = "Start Cooking: \(store.startCookingTime)"
        self.startCookingTimeField.centerYAnchor.constraint(equalTo: self.servingTimeView.centerYAnchor).isActive = true
        self.startCookingTimeField.leftAnchor.constraint(equalTo: self.servingTimeView.leftAnchor, constant: 16).isActive = true
        self.startCookingTimeField.rightAnchor.constraint(equalTo: self.servingTimeView.centerXAnchor).isActive = true
        self.startCookingTimeField.translatesAutoresizingMaskIntoConstraints = false
        self.startCookingTimeField.textAlignment = .left
        
        // tableview
        self.tableView.topAnchor.constraint(equalTo: self.servingTimeView.topAnchor, constant: -16).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.toolbar.topAnchor, constant: 0).isActive = true
        self.tableView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        // toolbar
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let toolbarButtons = [self.ingredientsButton, spacer, self.clearAllButton, spacer, self.openSingleStepButton]
        ingredientsButton.tintColor = UIColor(named: UIColor.ColorName(rawValue: UIColor.ColorName.beige.rawValue)!)
        clearAllButton.tintColor = UIColor(named: UIColor.ColorName(rawValue: UIColor.ColorName.beige.rawValue)!)
        openSingleStepButton.tintColor = UIColor(named: UIColor.ColorName(rawValue: UIColor.ColorName.beige.rawValue)!)
        
        self.toolbar.setItems(toolbarButtons, animated: false)
        
        // timepicker
        self.timePicker.backgroundColor = UIColor.white
        self.timePicker.layer.shadowOpacity = 0.5
        self.timePicker.datePickerMode = .time
        self.timePicker.minimumDate = store.earliestPossibleServeTime  // change to earliest serve time when available
        self.timePicker.minuteInterval = 15
    }
    
    func doneClickTimePicker() {
        let dateFormatterInst = DateFormatter()
        dateFormatterInst.dateStyle = .none
        dateFormatterInst.timeStyle = .short
        self.servingTimeField.text = "Serving Time: \(dateFormatterInst.string(from: self.timePicker.date))"
        self.servingTimeField.resignFirstResponder()
        
        // update serving time on the selected recipes
        for recipeSelected in self.store.recipesSelected {
            recipeSelected.servingTime = self.timePicker.date as NSDate?
        }
        self.store.saveRecipesContext()
        
        // recalculate start cooking time
        store.calculateStartTime()
        self.startCookingTimeField.text = "Start Cooking: \(store.startCookingTime)"
    }
    
    func cancelClickTimePicker() {
        self.servingTimeField.resignFirstResponder()
    }
    
    func createPickerToolBar() -> UIToolbar {
        let toolbarPicker = UIToolbar()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(self.doneClickTimePicker))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelClickTimePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolbarPicker.sizeToFit()
        toolbarPicker.setItems([cancelButton, spaceButton, doneButton], animated: false)
        return toolbarPicker
    }
    
    // setup tableview
    func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return store.recipesSelected.count}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // set the custom cell
        let cell = MyMenuTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "prototypeCell")
        cell.delegate = self
        cell.deleteButton.accessibilityLabel = String(indexPath.row)
        cell.selectionStyle = .none
        self.getBackgroundImage(recipe: self.store.recipesSelected[indexPath.row], imageView: cell.imageViewInst, view: cell)
        cell.recipeDescField.text = self.store.recipesSelected[indexPath.row].displayName
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // the tableview cells always fill the page
        let rowHeight = (tableView.bounds.height-60)/CGFloat(store.recipesSelected.count)
        return rowHeight
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // onClick table cell go to recipe
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        self.recipeForTraditionalRecipeView = store.recipesSelected[indexPath.row]
        self.delegate?.goToRecipe()
    }
    
    //re-call recipesSelected from API, re-sort, re-append to mergedStepsArray
    func updateTableViewNow() {
        UserDefaults.standard.set(0, forKey: "stepCurrent")
        if store.mergedStepsArray.count > 0 {
            store.calculateStartTime()
            self.startCookingTimeField.text = "Start Cooking: \(store.startCookingTime)"
        }
        self.tableView.reloadData()
    }
    
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
    
    func clickIngredients() {
        self.delegate?.goToIngredients()
    }
    
    func onClickClearAllRecipes() {
        self.delegate?.clearAllRecipes()
    }
    
    func clickOpenStep() {
        self.delegate?.goToSingleStep()
    }
    
    func getBackgroundImage(recipe: Recipe, imageView: UIImageView, view: UIView) {
        // The tableview cells crop images nicely when they are background images. This function gets a background image, stores it in the object and then sets it on the imageView that was passed in.
        if let imageURL = recipe.imageURL {
            let imageUrl:URL = URL(string: imageURL)!
            // Start background thread so that image loading does not make app unresponsive
            DispatchQueue.global(qos: .userInitiated).async {
                if let imageData = NSData(contentsOf: imageUrl) {
                    // When from background thread, UI needs to be updated on main_queue
                    DispatchQueue.main.async {
                        imageView.backgroundColor = UIColor(patternImage: UIImage(data: imageData as Data)!)
                        view.addSubview(imageView)
                        view.sendSubview(toBack: imageView)
                    }
                }
            }
        }
    }
}


//extensions to convert step properties duration and timeToStart to integers
extension String {
    func convertDurationToMinutes() -> Int {
        
        let separatedNum = self.components(separatedBy: ":")
        let handleMinutesOnly = Int(separatedNum[0])
        let handleHours = Int(separatedNum[0])
        let handleMinutesWithHours = Int(separatedNum[1])
        var totalMinutes: Int = 0
        
        switch separatedNum.count {
        case 2:
            totalMinutes += handleMinutesOnly!
        case 3:
            totalMinutes += ((handleHours! * 60) + (handleMinutesWithHours!))
        default:
            print("error")
        }
        return totalMinutes
    }
    
    
    func convertTimeToStartToMinutes() -> Int {
        let separatedNum = self.components(separatedBy: ":")
        let handleMinutesOnly = Int(separatedNum[0])
        let handleHours = Int(separatedNum[0])
        let handleMinutesWithHours = Int(separatedNum[1])
        var totalMinutes: Int = 0
        
        switch separatedNum.count {
        case 2:
            totalMinutes += handleMinutesOnly!
        case 3:
            totalMinutes += ((handleHours! * 60) - (handleMinutesWithHours!))
        default:
            print("error")
        }
        return totalMinutes
    }
    
}

