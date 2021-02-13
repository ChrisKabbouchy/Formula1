//
//  RacesViewController.swift
//  Formula1
//
//  Created by Christian Kabouchy on 11/15/20.
//

import UIKit

class StandingViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var DriverTableView: UITableView!
    
    var driverModel : DriversStandingsModel?
    var constructorModel : ConstructorStandingsModel?
    var segmentChoice : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DriverTableView.dataSource = self
        DriverTableView.delegate = self
        var formulaManager = FormulaManger()
        formulaManager.delegate = self
        formulaManager.fetchStandingsData()
        formulaManager.fetchConstructorData()
        
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
            return driverModel?.driversInfoList.count ?? 0
        case 1:
            return constructorModel?.constructorsInfoList.count ?? 0
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DriverCell", for: indexPath) as! DriverCell
        //cell.layer.borderWidth = 2
        switch segmentChoice {
        case 0://user selected drivers standings
            let driverItem = driverModel?.driversInfoList[indexPath.row]
            cell.driverName.text = "\(driverItem?.driverName ?? "") \(driverItem?.driverLastName ?? "") "
            cell.teamColor.backgroundColor = UIColor(named:(driverItem?.constructor) ?? "AlphaTauri")
            cell.teamColor.layer.borderWidth = 0.25
            cell.teamColor.layer.borderColor = UIColor.black.cgColor
            cell.standingsLeftImage.image = UIImage(named: driverItem?.nationality ?? "Mercedes")
            cell.carImage.isHidden = true
            cell.driverImage.isHidden = false
            cell.driverImage.image = UIImage(named: driverItem?.driverLastName ?? "Hamilton")
            //cell.contentView.layer.borderColor = UIColor(named:(driverItem?.constructor) ?? "AlphaTauri")?.cgColor
            
        case 1 :// user selected constructor standings
            let constructorItem = constructorModel?.constructorsInfoList[indexPath.row]
            cell.driverName.text = constructorItem?.constructorName
            cell.teamColor.backgroundColor = UIColor(named: (constructorItem?.constructorName) ?? "AlphaTauri")
            cell.teamColor.layer.borderWidth = 0.25
            cell.teamColor.layer.borderColor = UIColor.black.cgColor
            cell.standingsLeftImage.image = UIImage(named: constructorItem?.constructorName ?? "Mercedes")
            cell.driverImage.isHidden = true
            cell.carImage.isHidden = false
            cell.carImage.image = UIImage(named: "\(constructorItem?.constructorName ?? "Mercedes")-car")
            // cell.layer.borderWidth = 2
            //cell.contentView.layer.borderColor = UIColor(named: (constructorItem?.constructorName) ?? "AlphaTauri")?.cgColor
            
        default:
            break
        }
        return cell
    }
    
    //MARK: -Segue to Driver or Constructor Details
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch segmentChoice {
        case 0:
            performSegue(withIdentifier: "goToDriverDetails", sender: self)
        case 1:
            performSegue(withIdentifier: "goToConstructorDtails", sender: self)
        default:
            break
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segmentChoice {
        case 0:
            let driverVC = segue.destination as! DriverDetailsViewController
            let index = DriverTableView.indexPathForSelectedRow
            driverVC.driverDetails = driverModel?.driversInfoList[index!.row]
        case 1:
            let constructorVC = segue.destination as! ConstructorDetailsViewController
            let index = DriverTableView.indexPathForSelectedRow
            constructorVC.constructorDetail = constructorModel?.constructorsInfoList[index!.row]
        default:
            break
        }
        
    }
    
    //MARK: -Formula Manager delegate
    
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
