//
//  RacesCell.swift
//  Formula1
//
//  Created by Christian Kabouchy on 11/18/20.
//

import UIKit

class RacesCell: UITableViewCell {
    
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var racesImage: UIImageView!
    @IBOutlet var raceName: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var roundLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
