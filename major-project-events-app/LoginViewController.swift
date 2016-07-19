//
//  LoginViewController.swift
//  major-project-events-app
//
//  Created by Alex Stevens on 14/07/16.
//  Copyright © 2016 Alexander Stevens. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard)))
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
        //self.callService()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc
    private func dismissKeyboard() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    func callService() {
        Alamofire.request(.GET, "http://api.majorproject.dev/school/")
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField == emailTextField) {
            // If on email.
            if (!(passwordTextField.text?.isEmpty)!) {
                // And password is not empty
                self.signInTapped(self)
            } else {
                // Return to password text field.
                passwordTextField.becomeFirstResponder()
            }
        } else if (textField == passwordTextField) {
            // If on password.
            let isEmailEmpty: Bool = emailTextField.text!.isEmpty
            
            if ((!isEmailEmpty && !(passwordTextField.text?.isEmpty)!)) {
                // And email + password text fields are not empty, return to sign in button.
                self.signInTapped(self)
            } else if ((emailTextField.text?.isEmpty)!) {
                // And email is empty.
                emailTextField.becomeFirstResponder()
            }
        } else {
            // If else, return to no keyboard.
            self.dismissKeyboard()
        }
        
        return true
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            if view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
            else {
                
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            if view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height
            }
            else {
                
            }
        }
    }

    @IBAction func signInTapped(sender: AnyObject) {
        let email = emailTextField.text
        let password = passwordTextField.text
        
        // Send request of login details to server.
        email
        password
        
        if (true) { // If login is successful.
            
            // Set a global that user is logged in.
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIn")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            // Move to Tab Bar Controller.
            self.performSegueWithIdentifier("TabBarViewSegue", sender: self)
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
