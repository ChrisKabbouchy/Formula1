//
//  RacesCell.swift
//  Formula1
//
//  Created by Christian Kabouchy on 11/18/20.
//

import UIKit

class RacesCell: UITableViewCell {
    
    @IBOutlet var raceName: UILabel!
    @IBOutlet var racesImage: UIImageView!
    @IBOutlet var country: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var roundLabel: UILabel!
    @IBOutlet var countyImage: UIImageView!
    @IBOutlet var circuitName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
