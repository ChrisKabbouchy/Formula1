//
//  NewsCell.swift
//  Formula1
//
//  Created by Christian Kabouchy on 27/01/2021.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet var newsImage: UIImageView!
    @IBOutlet var newsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
