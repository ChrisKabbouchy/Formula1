//
//  RaceResultViewController.swift
//  Formula1
//
//  Created by Christian Kabouchy on 11/29/20.
//

import UIKit

class RaceResultViewController: UIViewController,UITableViewDelegate {
    
    var raceResultModel : RaceResultModel?
    var round : String?
    
    @IBOutlet var raceResultTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        raceResultTableView.delegate = self
        raceResultTableView.dataSource = self
        var formulaManager = FormulaManger()
        formulaManager.delegate = self
        formulaManager.fetchRaceResult(round: round ?? "1")
        // Do any additional setup after loading the view.
    }
}

//MARK: -Table view
extension RaceResultViewController : UITableViewDataSource,FormulaMangerDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return raceResultModel?.raceResultInfoList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RaceResultCell", for: indexPath) as! RaceResultCell
        let driverIndex = raceResultModel?.raceResultInfoList[indexPath.row]
        cell.positionLabel.text = driverIndex?.position
        cell.teamColor.backgroundColor = UIColor(named:(driverIndex?.constructorName) ?? "AlphaTauri")
        cell.driverCode.text = driverIndex?.code
        cell.status.text = driverIndex?.status
        cell.lapTime.text = driverIndex?.lapTime
        cell.points.text = driverIndex?.points
        return cell
    }
    
    //MARK: -Formula manager delegate
    func raceResultDataDidLoad (RaceResult : RaceResultModel){
        raceResultModel = RaceResult
        DispatchQueue.main.async {
            self.raceResultTableView.reloadData()
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
    //MARK: -No Race Data
    func noDataAvailable() {
        checkData()
    }
    
    func checkData() {
        if raceResultModel?.raceResultInfoList.first == nil {
            let alertController = UIAlertController(
                title: "Too early!",
                message:"The race did not occurred yet! ",
                preferredStyle: .alert)

            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default){_ in
                DispatchQueue.main.async {
                    self.dismiss(animated: true)
                }
            })
            DispatchQueue.main.async {
                self.present(alertController, animated: true, completion: nil)
            }
            
        }
    }
    
}
