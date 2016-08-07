//
//  EventsTableViewController.swift
//  major-project-events-app
//
//  Created by Alex Stevens on 14/07/16.
//  Copyright © 2016 Alexander Stevens. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

struct CellData {
    var organizerId: Int?
    var title: String?
    var description: String?
    var dateTime: String?
    var location: String?
    var price: Int?
    var limitReservations: Int?
}

class EventsTableViewController: UITableViewController {
    
    var dataSource:[CellData] = [CellData]()
    
    var eventOrganizerId: Int!
    var eventTitle: String!
    var eventDescription: String!
    var eventDate: String!
    var eventLocation: String!
    var eventPrice: Int!
    var eventReservations: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "EventsTableViewCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "EventsTableViewCellID")

        self.tableView.estimatedRowHeight = 124
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func getAllEventsData() {
        // Empties out data in array
        self.dataSource.removeAll()
        
        // Request all events
        Alamofire.request(.GET, "http://api.majorproject.dev/event/").validate().responseJSON { response in
            if let JSON = response.result.value {
                // Map JSON response to events
                let events = Mapper<CompleteEventResponse>().map(JSON)
                
                // Assign events.data to eventData
                guard let eventData = events?.data else { return }
                
                // Assign each event data to dataSource
                for event in eventData {
                    
                    var c = CellData()
                    c.organizerId = event.organizerId
                    c.title = event.title
                    c.description = event.eventDescription
                    c.dateTime = event.dateTime
                    c.location = event.location
                    c.price = event.price
                    c.limitReservations = event.limitReservations
                    
                    self.dataSource.append(c)
                }
                
                // Sort events
                self.dataSource.sortInPlace({ (event1:CellData, event2:CellData) -> Bool in
                    event1.dateTime < event2.dateTime
                })
                
                // Reload TableView data
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.getAllEventsData()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let data = self.dataSource[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCellWithIdentifier("EventsTableViewCellID", forIndexPath: indexPath) as? EventsTableViewCell else {
            fatalError("Could not requeue cell: \(EventsTableViewCell.self) with identifier: EventsTableViewCellID")
        }

        cell.configureCell(data)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = self.tableView.cellForRowAtIndexPath(indexPath) as! EventsTableViewCell
        self.eventOrganizerId = Int(cell.organizerIdLabel)
        self.eventTitle = cell.titleLabel.text
        self.eventDescription = cell.descriptionLabel
        self.eventDate = cell.dateTimeLabel.text
        self.eventLocation = cell.locationLabel.text
        if cell.priceLabel != nil {
            self.eventPrice = Int(cell.priceLabel)
        } else {
            self.eventPrice = nil
        }
        
        if cell.limitReservationsLabel != nil {
            self.eventReservations = Int(cell.limitReservationsLabel)
        } else {
            self.eventReservations = nil
        }
        self.performSegueWithIdentifier("eventsToEvent", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "eventsToEvent" {
            if let destination = segue.destinationViewController as? SingleEventTableViewController {
                if (self.eventOrganizerId != nil) {
                    destination.eventOrganizerId = self.eventOrganizerId
                }
                
                if !(self.eventTitle?.isEmpty)! {
                    destination.eventTitle = self.eventTitle
                }
                
                if !(self.eventDescription?.isEmpty)! {
                    destination.eventDescription = self.eventDescription
                }
                
                if !(self.eventDate?.isEmpty)! {
                    destination.eventDate = self.eventDate
                }
                
                if !(self.eventLocation?.isEmpty)! {
                    destination.eventLocation = self.eventLocation
                }
                
                if (self.eventPrice != nil) {
                    destination.eventPrice = self.eventPrice
                }
                
                if (self.eventReservations != nil) {
                    destination.eventReservations = self.eventReservations
                }
            }
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

}
