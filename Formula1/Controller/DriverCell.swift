//
//  TableViewCell.swift
//  Formula1
//
//  Created by Christian Kabouchy on 11/15/20.
//

import UIKit

class DriverCell: UITableViewCell {

    @IBOutlet var standingsLeftImage: UIImageView!
    @IBOutlet var teamColor: UIView!
    @IBOutlet var driverName: UILabel!
    @IBOutlet var carImage: UIImageView!
    @IBOutlet var driverImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
}
