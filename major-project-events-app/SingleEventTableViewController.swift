//
//  SingleEventTableViewController.swift
//  major-project-events-app
//
//  Created by Alex Stevens on 06/08/16.
//  Copyright © 2016 Alexander Stevens. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class SingleEventTableViewController: UITableViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var organizerLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var reservationsLabel: UILabel!
        
    var eventOrganizerId: Int!
    var eventTitle: String!
    var eventDescription: String!
    var eventDate: String?
    var eventLocation: String!
    var eventPrice: Int!
    var eventReservations: Int!
    
//    var organizerData: NSMutableDictionary = [:]
//    var userUsername: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.eventOrganizerId != nil {
            let organizerData = getOrganizerInfo(eventOrganizerId)
            self.organizerLabel.text = organizerData["username"]
        } else {
            self.organizerLabel.text = "Unknown organizer"
        }
        self.titleLabel.text = self.eventTitle
        self.descriptionLabel.text = self.eventDescription
        self.dateLabel.text = self.eventDate
        self.locationLabel.text = self.eventLocation
        
        if self.eventPrice != nil {
            self.priceLabel.text = String(self.eventPrice)
        } else {
            self.priceLabel.text = "Free"
        }
        
        if self.eventReservations != nil {
            self.reservationsLabel.text = String(self.eventReservations)
        } else {
            self.reservationsLabel.text = "Unlimited"
        }
    }
    
    func getOrganizerInfo(organizerId: Int) -> Dictionary<String, String> {
        var organizerData: [String: String] = [:]
        
        // Request user from id
        Alamofire.request(.GET, "http://api.majorproject.dev/user/\(organizerId)").validate().responseJSON { response in
            if let JSON = response.result.value {
                // Map JSON response to user
                let user = Mapper<CompleteUserResponse>().map(JSON)
                
                // Assign user.data to userData
                guard let userData = user?.data else { return }
                
                organizerData = [
                    "id": String(userData.id),
                    "username": userData.username!,
                    "email": userData.email!,
                ]
                
//                self.userUsername = userData.username!
            }
        }
        print(organizerData)
        return organizerData
    }
    
}
