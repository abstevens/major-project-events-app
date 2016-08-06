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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "EventsTableViewCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "EventsTableViewCellID")

        self.tableView.estimatedRowHeight = 171
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func getAllEventsData() {
        // empties out data in array
        self.dataSource.removeAll()
        
        
        Alamofire.request(.GET, "http://api.majorproject.dev/event/").validate().responseJSON { response in
            if let JSON = response.result.value {
                    
                let events = Mapper<CompleteEventResponse>().map(JSON)
                
                guard let eventData = events?.data else { return }
                
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
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

}
