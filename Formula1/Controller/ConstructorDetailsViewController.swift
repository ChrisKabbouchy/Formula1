//
//  ConstructorDetailsViewController.swift
//  Formula1
//
//  Created by Christian Kabouchy on 12/01/2021.
//

import UIKit

class ConstructorDetailsViewController: UIViewController {

    @IBOutlet var constructorCar: UIImageView!
    @IBOutlet var constructorImage: UIImageView!
    @IBOutlet var teamColor: UIView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var flag: UIImageView!
    @IBOutlet var nationalityLabel: UILabel!
    @IBOutlet var pointLabel: UILabel!
    @IBOutlet var positionLabel: UILabel!
    @IBOutlet var winsLabel: UILabel!
    
    @IBAction func backButtonPressed(_ sender: Any) {
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
    }
    var constructorDetail : ConstructorsInfoList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = constructorDetail?.constructorName
        constructorCar.image = UIImage(named: "\(constructorDetail?.constructorName ?? "Mercedes")-car")
        constructorImage.image = UIImage(named: constructorDetail?.constructorName ?? "Mercedes")
        teamColor.backgroundColor = UIColor(named: constructorDetail?.constructorName ?? "Mercedes")
        flag.image = UIImage(named: constructorDetail?.nationality ?? "")
        nationalityLabel.text = constructorDetail?.nationality
        pointLabel.text = "Points : \(constructorDetail?.points ?? "")"
        positionLabel.text = "Position : \(constructorDetail?.position ?? "")"
        winsLabel.text = "Wins : \(constructorDetail?.wins ?? "")"

    }
    

}
