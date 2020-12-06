//
//  StandingsModel.swift
//  Formula1
//
//  Created by Christian Kabouchy on 11/19/20.
//

import Foundation

struct DriversStandingsModel  {
    var season : String
    var round : String
    var driversInfoList : [DriversInfoList]
}
struct DriversInfoList {
    var position : Int
    var driverName : String
    var driverLastName : String
    var points : String
    var driverNumber : String
    var nationality : String
    var dateOfBirth : String
    var constructor : String
    var permanentNumber : String
    
}
