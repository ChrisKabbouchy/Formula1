//
//  TableViewCell.swift
//  Formula1
//
//  Created by Christian Kabouchy on 11/01/2021.
//

import UIKit

class RaceResultCell: UITableViewCell {

    @IBOutlet var positionLabel: UILabel!
    @IBOutlet var driverCode: UILabel!
    @IBOutlet var status: UILabel!
    @IBOutlet var teamColor: UIView!
    @IBOutlet var lapTime: UILabel!
    @IBOutlet var points: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
