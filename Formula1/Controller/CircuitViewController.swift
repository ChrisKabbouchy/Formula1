//
//  CircuitViewController.swift
//  Formula1
//
//  Created by Christian Kabouchy on 09/02/2021.
//

import UIKit
import SwiftUI
import MapKit
import CoreLocation

class CircuitViewController: UIViewController {
    
    var racesModel : racesInfoList?
    var index : IndexPath?
    
    @IBOutlet var map: MKMapView!
    @IBOutlet var raceResultButton: UIButton!
    @IBOutlet var raceName: UILabel!
    @IBOutlet var round: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var time: UILabel!
    @IBOutlet var flag: UIImageView!
    @IBOutlet var countryName: UILabel!
    @IBOutlet var locality: UILabel!
    @IBOutlet var circuitName: UILabel!
    @IBOutlet var circuitImage: UIImageView!
    
    @IBAction func raceResultPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToRaceResult", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMap()
        raceName.text = racesModel?.raceName
        round.text = "Round: \(racesModel?.round ?? "")"
        date.text = racesModel?.date
        time.text = racesModel?.time
        flag.image = UIImage(named: racesModel?.country ?? "Country TBC") ?? UIImage(named: "Country TBC")
        countryName.text = racesModel?.country
        locality.text = "City: \(racesModel?.locality ?? "")"
        circuitName.text = racesModel?.circuitName
        circuitImage.image = UIImage(named: racesModel?.circuitName ?? "Yas Marina Circuit") ?? UIImage(named: "TBC")
        
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let resultVC = segue.destination as! RaceResultViewController
        resultVC.round = racesModel?.round
        
    }
    fileprivate func setMap() {
        
        let Lat = Double(racesModel!.lat) ?? 0
        let Long = Double(racesModel!.long) ?? 0
        let center = CLLocationCoordinate2D(latitude: Lat, longitude: Long)
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        let location = MKPointAnnotation()
        location.title = racesModel?.circuitName
        location.coordinate = CLLocationCoordinate2D(latitude: Lat, longitude: Long)
        map.addAnnotations([location])
        map.setRegion(region, animated: true)
    }
}
