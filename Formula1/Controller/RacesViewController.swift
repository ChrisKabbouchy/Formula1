//
//  StandingsViewController.swift
//  Formula1
//
//  Created by Christian Kabouchy on 11/15/20.
//

import UIKit

class RacesViewController: UIViewController {

    @IBOutlet var RacesTableView: UITableView!
    override func viewDidLoad() {
        RacesTableView.dataSource = self
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
extension RacesViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "RacesCell", for: indexPath) as! RacesCell
        cell.countryLabel.text = "italy"
        cell.dateLabel.text = "15-12-2020"
        cell.raceName.text = "Monza grand prix 2020"
        cell.roundLabel.text = "round 17"
        cell.racesImage.image = UIImage(systemName: "gamecontroller")
        
        return cell
    }
    
    
}
