//
//  RacesViewController.swift
//  Formula1
//
//  Created by Christian Kabouchy on 11/15/20.
//

import UIKit

class StandingViewController: UIViewController {

    @IBOutlet var DriverTableView: UITableView!
    
    var driverModel : DriversStandingsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DriverTableView.dataSource = self
        var formulaManager = FormulaManger()
        formulaManager.delegate = self
        formulaManager.fetchStandingsData()
        formulaManager.fetchConstructorData()
        print("hello")

        // Do any additional setup after loading the view.
    }
}

//MARK: -Table view

extension StandingViewController : UITableViewDataSource ,FormulaMangerDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return driverModel?.driversInfoList.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DriverCell", for: indexPath) as! DriverCell
        cell.constructorImage.image = UIImage(systemName: "gamecontroller")
        cell.driverName.text = "\(driverModel?.driversInfoList[indexPath.row].driverName ?? "") \(driverModel?.driversInfoList[indexPath.row].driverLastName ?? "") "
        return cell
    }
    
    func driversDataDidLoad(Drivers: DriversStandingsModel) {
        driverModel = Drivers
        DispatchQueue.main.async {
            self.DriverTableView.reloadData()
        }
        
    }
    
    func constructorDataDidLoad(Constructors: ConstructorStandingsModel) {
        
    }
    
    func errorOccurred(error: Error) {
        
    }
    
    
}
