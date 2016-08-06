//
//  CreateTableViewController.swift
//  major-project-events-app
//
//  Created by Alex Stevens on 14/07/16.
//  Copyright © 2016 Alexander Stevens. All rights reserved.
//

import UIKit
import Alamofire

class CreateTableViewController: UITableViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var dateDetailLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var limitReservationsTextField: UITextField!
    
    
    var datePickerHidden: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.delegate = self
        descriptionTextView.delegate = self
        locationTextField.delegate = self
        priceTextField.delegate = self
        limitReservationsTextField.delegate = self
        
        toggleDatepicker()
        self.datePickerChanged()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch textField {
        case titleTextField:
            descriptionTextView.becomeFirstResponder()
            break
        case locationTextField:
            priceTextField.becomeFirstResponder()
            break
        case priceTextField:
            limitReservationsTextField.becomeFirstResponder()
            break
        default:
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    func datePickerChanged () {
        dateDetailLabel.text = NSDateFormatter.localizedStringFromDate(datePicker.date, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.section == 0 && indexPath.row == 2) {
            toggleDatepicker()
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (datePickerHidden && indexPath.section == 0 && indexPath.row == 3) {
            return 0
        }
        else {
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        }
    }
    
    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if ((indexPath.section == 0 && indexPath.row == 2)) {
            return true
        } else {
            return false
        }
    }
    
    func toggleDatepicker() {
        datePickerHidden = !datePickerHidden
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    @IBAction func datePickerValue(sender: AnyObject) {
        self.datePickerChanged()
    }
    
    
    @IBAction func createTapped(sender: AnyObject) {
        let title = titleTextField.text ?? ""
        let description = descriptionTextView.text ?? ""
        let date = dateDetailLabel.text ?? ""
        let location = locationTextField.text ?? ""
        let price = Int(priceTextField.text ?? "")
        let limitReservations = Int(limitReservationsTextField.text ?? "")
        
        var hasBasic: Bool = false
        var hasAdvanced: Bool = false
        
        if (title.isEmpty || description.isEmpty || date.isEmpty || location.isEmpty) {
            // Require basic informaiton
            let alertTitle: String = "Fields required"
            let alertMessage: String = "All basic information field must be filled out."
            let alertButton: String = "OK"
            
            let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.Alert)
            let okButton = UIAlertAction(title: alertButton, style: .Default, handler: nil)
            alert.addAction(okButton)
            
            presentViewController(alert, animated: true, completion: nil)
        } else if (price == nil || limitReservations == nil) {
            // Ask to fill out advanced information
            let alertTitle: String = "Advanced information"
            let alertMessage: String = "You have not filled out the advanced information, are you sure you want to continue?"
            let alertOkButton: String = "OK"
            let alertCancelButton: String = "Cancel"
            
            let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: alertOkButton, style: .Default, handler: { (action: UIAlertAction!) in
                hasBasic = true
            }))
            alert.addAction(UIAlertAction(title: alertCancelButton, style: .Cancel, handler: nil))
            
            presentViewController(alert, animated: true, completion: nil)
        } else {
            hasBasic = true
            hasAdvanced = true
        }
        
        if hasBasic {
            // make data package and send to server
            var data = EventNode()!
            data.organizerId = 1
            data.title = title
            data.eventDescription = description
            data.dateTime = date
            data.location = location
            
            if hasAdvanced {
                data.price = price
                data.limitReservations = limitReservations
            } else {
                data.price = nil
                data.limitReservations = nil
            }
            print(data.toJSONString()!)

            storeData(data)
            let alertTitle: String = "Event Saved"
            let alertMessage: String = "You have successfully created a new event!"
            let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
                
            }))
            presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    
    func storeData(data: EventNode) {
        Alamofire.request(.POST, "http://api.majorproject.dev/event/", parameters: data.toJSON(), encoding: .JSON).responseJSON { response in
            return response.result.isSuccess
        }
    }
    
}
