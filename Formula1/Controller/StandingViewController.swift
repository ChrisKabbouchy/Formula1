//
//  RacesViewController.swift
//  Formula1
//
//  Created by Christian Kabouchy on 11/15/20.
//

import UIKit

class StandingViewController: UIViewController {
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var DriverTableView: UITableView!
    
    var driverModel : DriversStandingsModel?
    var constructorModel : ConstructorStandingsModel?
    var segmentChoice : Int = 0
    
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
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            segmentChoice = 0
            DriverTableView.reloadData()
        case 1:
            segmentChoice = 1
            DriverTableView.reloadData()
        default: break
            
        }
    }
}

//MARK: -Table view

extension StandingViewController : UITableViewDataSource ,FormulaMangerDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentChoice {
        case 0:
            return driverModel?.driversInfoList.count ?? 1
        case 1:
            return constructorModel?.constructorsInfoList.count ?? 1
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DriverCell", for: indexPath) as! DriverCell
        cell.constructorImage.image = UIImage(systemName: "gamecontroller")
        switch segmentChoice {
        case 0:
            cell.driverName.text = "\(driverModel?.driversInfoList[indexPath.row].driverName ?? "") \(driverModel?.driversInfoList[indexPath.row].driverLastName ?? "") "
        case 1 : cell.driverName.text = constructorModel?.constructorsInfoList[indexPath.row].constructorName
        default:
            break
        }
        
        return cell
    }
    //MARK: -Formula delegate func
    
    func driversDataDidLoad(Drivers: DriversStandingsModel) {
        driverModel = Drivers
        DispatchQueue.main.async {
            self.DriverTableView.reloadData()
        }
        
    }
    func constructorDataDidLoad(Constructors: ConstructorStandingsModel) {
        constructorModel = Constructors
        DispatchQueue.main.async {
            self.DriverTableView.reloadData()
        }
    }
    func errorOccurred(error: Error) {
        
    }
    
    
}
