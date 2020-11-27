//
//  StandingsViewController.swift
//  Formula1
//
//  Created by Christian Kabouchy on 11/15/20.
//

import UIKit

class RacesViewController: UIViewController {
    
    @IBOutlet var RacesTableView: UITableView!
    
    var racesModel : RaceScheduleModel?
    
    override func viewDidLoad() {
        RacesTableView.dataSource = self
        super.viewDidLoad()
        var formulaManager = FormulaManger()
        formulaManager.delegate = self
        formulaManager.fetchRacesData()
        
        // Do any additional setup after loading the view.
    }
    
}

//MARK: -Table view
extension RacesViewController : UITableViewDataSource,FormulaMangerDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return racesModel?.racesInfoList.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "RacesCell", for: indexPath) as! RacesCell
        let raceItem = racesModel?.racesInfoList[indexPath.row]
        cell.countryLabel.text = raceItem?.country
        cell.dateLabel.text = raceItem?.date
        cell.raceName.text = raceItem?.raceName
        cell.roundLabel.text = raceItem?.round
        cell.racesImage.image = UIImage(named: raceItem?.circuitName ?? "Yas Marina Circuit")
        cell.racesImage.backgroundColor = UIColor.black
        
        return cell
    }
    //MARK: -Formula delegate func
    func racesScheduleDataDidLoad(Races: RaceScheduleModel) {
        racesModel = Races
        DispatchQueue.main.async {
            self.RacesTableView.reloadData()
        }
    }
    func errorOccurred(error: Error) {
        let alertController = UIAlertController(
            title: "Error Occured",
            message:error.localizedDescription,
            preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
}
