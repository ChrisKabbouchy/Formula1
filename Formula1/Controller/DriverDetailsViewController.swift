//
//  ViewController.swift
//  Formula1
//
//  Created by Christian Kabouchy on 11/15/20.
//

import UIKit

class DriverDetailsViewController: UIViewController {

    @IBOutlet var driverImage: UIImageView!
    @IBOutlet var driverName: UILabel!
    @IBOutlet var teamColor: UIView!
    @IBOutlet var teamImage: UIImageView!
    @IBOutlet var teamName: UILabel!
    @IBOutlet var nationalityImage: UIImageView!
    @IBOutlet var nationalityName: UILabel!
    @IBOutlet var points: UILabel!
    @IBOutlet var DOB: UILabel!
    @IBOutlet var permanentNumber: UILabel!
    
    var driverDetails : DriversInfoList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        driverName.text =  "\(driverDetails?.driverName ?? "") \(driverDetails?.driverLastName ?? "")"
        driverImage.image = UIImage(named: driverDetails?.driverLastName ?? "Hamilton")
        teamColor.backgroundColor = UIColor(named:(driverDetails?.constructor) ?? "AlphaTauri")
        teamName.text = driverDetails?.constructor
        teamImage.image = UIImage(named: driverDetails?.constructor ?? "")
        nationalityName.text = driverDetails?.nationality
        nationalityImage.image = UIImage(named: driverDetails?.nationality ?? "")
        points.text = "Points: \(driverDetails?.points ?? "")"
        DOB.text = "Date of Birth: \(driverDetails?.dateOfBirth ?? "")"
        permanentNumber.text = driverDetails?.permanentNumber
        
        
        // Do any additional setup after loading the view.
    }


}

