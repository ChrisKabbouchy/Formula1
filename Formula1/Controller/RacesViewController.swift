//
//  StandingsViewController.swift
//  Formula1
//
//  Created by Christian Kabouchy on 11/15/20.
//

import UIKit

class RacesViewController: UIViewController ,UITableViewDelegate{
    
    @IBOutlet var RacesTableView: UITableView!
    
    var racesModel : RaceScheduleModel?
    
    override func viewDidLoad() {
        RacesTableView.dataSource = self
        RacesTableView.delegate = self
        super.viewDidLoad()
        var formulaManager = FormulaManger()
        formulaManager.delegate = self
        formulaManager.fetchRacesData()
        formulaManager.fetchRaceResult(round: "15")
        
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
        cell.raceName.text = raceItem?.raceName
        cell.dateLabel.text = raceItem?.date
        cell.country.text = raceItem?.country
        cell.circuitName.text = raceItem?.circuitName
        cell.countyImage.image = UIImage(named: raceItem?.country ?? "Country TBC") ?? UIImage(named: "Country TBC")
        cell.roundLabel.text = "Round: \(raceItem?.round ?? "")"
        cell.racesImage.image = UIImage(named: raceItem?.circuitName ?? "Yas Marina Circuit") ?? UIImage(named: "TBC")
        
        return cell
    }

    //MARK: - Segue to circuit
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToCircuit", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let circuitVC = segue.destination as! CircuitViewController
        let index = RacesTableView.indexPathForSelectedRow
        circuitVC.racesModel = racesModel?.racesInfoList[index!.row]
        circuitVC.index = index
        
    }
    //MARK: -Formula Manager Delegate
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
