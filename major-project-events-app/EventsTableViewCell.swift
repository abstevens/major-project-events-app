//
//  EventsTableViewCell.swift
//  major-project-events-app
//
//  Created by Alex Stevens on 18/07/16.
//  Copyright © 2016 Alexander Stevens. All rights reserved.
//

import UIKit

class EventsTableViewCell: UITableViewCell {
    
//    @IBOutlet weak var organizerIdLabel: UILabel!
    var organizerIdLabel: String!
    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var descriptionLabel: UILabel!
    var descriptionLabel: String!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
//    @IBOutlet weak var priceLabel: UILabel!
    var priceLabel: String!
//    @IBOutlet weak var limitReservationsLabel: UILabel!
    var limitReservationsLabel: String!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
//        self.contentView.backgroundColor = UIColor.greenColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(data: CellData) {
        if let oid = data.organizerId {
            self.organizerIdLabel = String(oid)
        }
        
        if let title = data.title {
            self.titleLabel.text = title
        }
        
        if let description = data.description {
            self.descriptionLabel = description
        }
        
        if let dateTime = data.dateTime {
            self.dateTimeLabel.text = dateTime
        }
        
        if let location = data.location {
            self.locationLabel.text = location
        }
        
        if let price = data.price {
            self.priceLabel = String(price)
        }
        
        if let limitReservations = data.limitReservations {
            self.limitReservationsLabel = String(limitReservations)
        }
    }
    
}
