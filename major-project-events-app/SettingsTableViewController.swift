//
//  SettingsTableViewController.swift
//  major-project-events-app
//
//  Created by Alex Stevens on 14/07/16.
//  Copyright © 2016 Alexander Stevens. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 0:
            break
        case 1:
            break
        case 2:
            // Set a global that user is not logged in
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isUserLoggedIn")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            // Move to SignInViewController
            self.performSegueWithIdentifier("SignOutViewSegue", sender: self)
            
            break
        default:
            return
        }
    }

}
