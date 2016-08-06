//
//  ProfileHeaderCell.swift
//  major-project-events-app
//
//  Created by Alex Stevens on 05/08/16.
//  Copyright © 2016 Alexander Stevens. All rights reserved.
//

import UIKit

class ProfileHeaderCell: UITableViewCell {
    
    @IBOutlet weak var profileHeader: UIImageView!
    @IBOutlet weak var profileLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.makeImageViewRound()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func makeImageViewRound() {
        let cornerRadius: CGFloat = self.profileHeader.frame.width * 0.5
        self.profileHeader.layer.cornerRadius = cornerRadius
        self.profileHeader.clipsToBounds = true
        self.profileHeader.layer.borderColor = UIColor.whiteColor().CGColor
        self.profileHeader.layer.borderWidth = 1
    }

    
    func configureCell(data: CellData) {

    }
}