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
        Alamofire.request(.GET, "http://api.majorproject.dev/event/").validate().responseJSON { response in
                print(response.request)  // original URL request

            if let JSON = response.result.value {
                    
                let events = Mapper<CompleteEventResponse>().map(JSON)
                print(events)
                
                guard let eventData = events?.data else { return }
                
                for event in eventData {
                    
                    let event = event as EventResponse?
                    
                    var c = CellData()
                    c.organizerId = event?.organizerId
                    c.title = event?.title
                    c.description = "uikuikui"
                    c.dateTime = event?.dateTime
                    c.location = "ergeg"
                    c.price = event?.price
                    c.limitReservations = event?.limitReservations
                    
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

    // MARK: - Table view data source

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
