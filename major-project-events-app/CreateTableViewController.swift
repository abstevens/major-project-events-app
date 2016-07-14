//
//  CreateTableViewController.swift
//  major-project-events-app
//
//  Created by Alex Stevens on 14/07/16.
//  Copyright © 2016 Alexander Stevens. All rights reserved.
//

import UIKit

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
        dateDetailLabel.text = NSDateFormatter.localizedStringFromDate(datePicker.date, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.NoStyle)
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
        let title: String! = titleTextField.text
        let description: String! = descriptionTextView.text
        let date: String! = dateDetailLabel.text
        let location: String! = locationTextField.text
        let price: Int? = Int(priceTextField.text!)
        let limitReservations: Int? = Int(limitReservationsTextField.text!)
        
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
                
            }))
            alert.addAction(UIAlertAction(title: alertCancelButton, style: .Cancel, handler: nil))
            
            presentViewController(alert, animated: true, completion: nil)
        } else {
            // Save the data
        }
    }


    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
