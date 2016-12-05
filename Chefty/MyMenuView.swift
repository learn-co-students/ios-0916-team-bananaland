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
    
    var recipeSteps = [Steps]()
    var addedTime = 0
    var servingTimeForDisplay = "test time here"
    
    let ingredientsButton: UIBarButtonItem = UIBarButtonItem(title: "Ingredients", style: .plain , target: self, action: #selector(clickIngredients))
    let clearAllButton: UIBarButtonItem = UIBarButtonItem(title: "Clear All", style: .plain , target: self, action: #selector(onClickClearAllRecipes))
    var openSingleStepButton: UIBarButtonItem = UIBarButtonItem(title: "Open Step", style: .plain , target: self, action: #selector(clickOpenStep))
    
    override init(frame:CGRect){
        super.init(frame: frame)
        
        self.getStepsFromRecipesSelected {
            self.mergeRecipeSteps()
            
            for step in self.recipeSteps {
                self.store.mergedStepsArray.append(step)
            }
            self.calculateStartTime()
            print("store.mergedStepsArray.count \(self.store.mergedStepsArray.count)")
        }
        
        
        // format the time
        let myFormatter = DateFormatter()
        myFormatter.timeStyle = .short
        
        if let servingTime = store.recipesSelected[0].servingTime {
            self.servingTimeValue = myFormatter.string(from: servingTime as Date)
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
        self.toolbar.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.toolbar.translatesAutoresizingMaskIntoConstraints = false
        
        // servingtime view
        self.servingTimeView.topAnchor.constraint(equalTo: self.topAnchor, constant: 64).isActive = true
        self.servingTimeView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.servingTimeView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.servingTimeView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        self.servingTimeView.translatesAutoresizingMaskIntoConstraints = false
        
        // define servingTimeView
        self.servingTimeField.font = UIFont(name: Constants.appFont.regular.rawValue, size: CGFloat(Constants.fontSize.small.rawValue))
        self.servingTimeField.textColor = self.tintColor
        self.servingTimeView.addSubview(self.servingTimeField)
        self.servingTimeField.text = self.servingTimeValue
        self.servingTimeField.centerYAnchor.constraint(equalTo: self.servingTimeView.centerYAnchor).isActive = true
        self.servingTimeField.leftAnchor.constraint(equalTo: self.servingTimeView.leftAnchor, constant: 10).isActive = true
        self.servingTimeField.rightAnchor.constraint(equalTo: self.servingTimeView.rightAnchor, constant: -10).isActive = true
        self.servingTimeField.translatesAutoresizingMaskIntoConstraints = false
        
        self.servingTimeField.inputView = self.timePicker
        self.servingTimeField.inputAccessoryView = self.createPickerToolBar()
        
        // tableview
        self.tableView.topAnchor.constraint(equalTo: self.servingTimeView.topAnchor, constant: -16).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.toolbar.topAnchor, constant: 0).isActive = true
        self.tableView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        // toolbar
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let toolbarButtons = [self.ingredientsButton, spacer, self.clearAllButton, spacer, self.openSingleStepButton]
        self.toolbar.setItems(toolbarButtons, animated: false)
        
        // timepicker
        self.timePicker.backgroundColor = UIColor.white
        self.timePicker.layer.shadowOpacity = 0.5
        self.timePicker.datePickerMode = .time
        self.timePicker.minimumDate = Date()  // change to earliest serve time when available
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
    }
    
    func cancelClickTimePicker() { self.servingTimeField.resignFirstResponder() }
    
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
        // the tableview cells are divided up to always fill the page
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
    
    func onClickClearAllRecipes() { self.delegate?.clearAllRecipes() }
    
    func clickOpenStep() { self.delegate?.goToSingleStep() }
    
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
    
    
    //Merged Steps Set Up
    
    func getStepsFromRecipesSelected(completion: @escaping () -> ()) {
        self.recipeSteps.removeAll()
        for singleRecipe in store.recipesSelected {
            DispatchQueue.main.async {
                CheftyAPIClient.getStepsAndIngredients(recipeIDRequest: singleRecipe.id!, completion: {
                })
            }
            let allRecipeSteps = singleRecipe.step!.allObjects as! [Steps]
            self.recipeSteps += allRecipeSteps
        }
        completion()
    }
    
    
    func mergeRecipeSteps() {
        
        print("added time at start of mergeSteps = \(self.addedTime)")
        
        self.recipeSteps = self.recipeSteps.sorted { (step1: Steps, step2: Steps) -> Bool in
            
            //same start
            if step1.timeToStart == step2.timeToStart {
                
                //different attentionNeeded
                if step1.fullAttentionRequired == false && step2.fullAttentionRequired == true {
                    return true
                } else if step1.fullAttentionRequired == true && step2.fullAttentionRequired == false {
                    addedTime += step1.timeToStart + step1.duration - step2.timeToStart
                    return false
                    
                    //same attentionNeeded, add shorter duration to addedTime
                } else if step1.fullAttentionRequired == step2.fullAttentionRequired {
                    if step1.duration > step2.duration {
                        addedTime += Int(step2.duration)
                        return false
                    } else if step1.duration < step2.duration {
                        addedTime += Int(step1.duration)
                        return true
                    }
                }
            }
            
            //overlap duration
            if (step2.timeToStart > step1.timeToStart) && (step2.timeToStart < (step1.timeToStart + step1.duration)) {
                
                if step1.fullAttentionRequired == false && step2.fullAttentionRequired == true {
                    addedTime += step2.timeToStart - (step1.timeToStart + step1.duration)
                    return true
                    
                } else if step1.fullAttentionRequired == true && step2.fullAttentionRequired == false {
                    addedTime += (step1.timeToStart + step1.duration) - step2.timeToStart
                    return true
                    
                } else if step1.fullAttentionRequired == step2.fullAttentionRequired {
                    addedTime += (step1.timeToStart + step1.duration) - step2.timeToStart
                    return true
                }
            }
            
            return step1.timeToStart < step2.timeToStart
            
        }
        
        print("added time at end of mergeSteps = \(self.addedTime)")
        
    }
    
    
    
    func calculateStartTime() {
        
        let currentTime = Date()
        print("current time: \(currentTime)")
        let calendar = Calendar.current
        
        var servingTime = store.recipesSelected[0].servingTime // default or user selected serving time is same for all 4 recipes
        print("serving time: \(servingTime)")
        
        //total cooking time = smallest timeToStart from mergedSteps + addedTime
        var totalCookingDuration = store.mergedStepsArray[0].timeToStart * -1 //+ addedTime
        print("time to start = \(store.mergedStepsArray[0].timeToStart)")
        //print("added time = \(addedTime)")
        print("total cooking time: \(totalCookingDuration)")
        
        //earliest possible serving time = current time + total cooking time
        let earliestPossibleServeTime = calendar.date(byAdding: .minute, value: Int(totalCookingDuration), to: currentTime)
        print("earliest serve time: \(earliestPossibleServeTime)")
        
        //start cooking time = serving time - total cooking duration
        let totalCookingDurationSeconds = totalCookingDuration * -60
        var startCookingTime = servingTime?.addingTimeInterval(TimeInterval(totalCookingDurationSeconds))
        print("start cooking at: \(startCookingTime)")
        
        //check that serving time is greater than earliest possible serving time
        // --> if yes, servingTime & start cooking time will work, so don't change
        if servingTime?.compare(earliestPossibleServeTime! as Date) == ComparisonResult.orderedDescending || servingTime?.compare(earliestPossibleServeTime! as Date) == ComparisonResult.orderedSame {
            print("start cooking time and serving time remains the same")
            
        } else {
            // --> if no, serving time = earliest possible serving time, start cooking time = earliest possible serving time - total duration
            servingTime = earliestPossibleServeTime as NSDate?
            print("input time error, earliest serving time possible = \(servingTime)")
            startCookingTime = earliestPossibleServeTime?.addingTimeInterval(TimeInterval(totalCookingDurationSeconds)) as NSDate?
        }
        print("final serving time = \(servingTime)")
        print("final start cooking time = \(startCookingTime)")
        guard let finalStartCookingTime = startCookingTime else { return }
        store.startCookingTime = "\(finalStartCookingTime)"
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

