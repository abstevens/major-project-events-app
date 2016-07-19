//
//  EventsTableViewCell.swift
//  major-project-events-app
//
//  Created by Alex Stevens on 18/07/16.
//  Copyright © 2016 Alexander Stevens. All rights reserved.
//

import UIKit

class EventsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var limitReservationsLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(data: CellData) {
        if let title = data.title {
            self.titleLabel.text = title
        }
        
        if let description = data.description {
            self.descriptionLabel.text = description
        }
        
        if let dateTime = data.dateTime {
            self.dateTimeLabel.text = dateTime
        }
        
        if let location = data.location {
            self.locationLabel.text = location
        }
        
        if let price = data.price {
            self.priceLabel.text = String(price)
        }
        
        if let limitReservations = data.limitReservations {
            self.limitReservationsLabel.text = String(limitReservations)
        }
    }
    
}
