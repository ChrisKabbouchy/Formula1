//
//  RacesViewController.swift
//  Formula1
//
//  Created by Christian Kabouchy on 11/15/20.
//

import UIKit

class StandingViewController: UIViewController ,UITableViewDelegate{

    @IBOutlet var UITableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        UITableView.dataSource = self

        // Do any additional setup after loading the view.
    }
}


extension StandingViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DriverCell", for: indexPath) as! DriverCell
        cell.constructorImage.image = UIImage(systemName: "gamecontroller")
        cell.driverName.text = "Max Verstapen"
        return cell
    }
    
    
}
