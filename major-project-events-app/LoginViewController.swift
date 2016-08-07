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
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard)))
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
        logoImageView.layer.cornerRadius = 8.0
        logoImageView.clipsToBounds = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc
    private func dismissKeyboard() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
//    func checkCredentials() {
//        let credentials = ["username": "...", "password": "..."]
//        
//        
//        Alamofire.request(.POST, "http://api.majorproject.dev/user/", parameters: credentials, encoding: .JSON).responseJSON { response in
//            debugPrint(response)
//        }
//
//    }
    
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
//        self.checkCredentials()
        
        if (email == "Test" && password == "1111") { // If login is successful.
            
            // Set a global that user is logged in.
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIn")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            // Move to Tab Bar Controller.
            self.performSegueWithIdentifier("TabBarViewSegue", sender: self)
        } else {
            let alertTitle: String = "Invaid Credentials"
            let alertMessage: String = "The email and password combination you have entered is not in our system. Please try again with a different email or password."
            let alertButton: String = "OK"
            
            let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: alertButton, style: .Cancel, handler: nil))
            
            presentViewController(alert, animated: true, completion: nil)
        }
    }

}
