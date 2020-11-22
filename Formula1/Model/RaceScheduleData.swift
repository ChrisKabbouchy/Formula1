//
//  RaceScheduleData.swift
//  Formula1
//
//  Created by Christian Kabouchy on 11/22/20.
//

import Foundation

struct RaceScheduleData : Decodable {
    var MRData : MRDataR
}
struct MRDataR : Decodable {
    var RaceTable : RaceTable
}
struct RaceTable : Decodable {
    var season : String
    var Races : [Races]
}
struct Races :Decodable {
    var season : String
    var round : String
    var raceName : String
    var Circuit : Circuit
    var date : String
    var time : String
    
}
struct Circuit :  Decodable {
    var circuitName : String
    var Location : Location
}
struct Location : Decodable {
    var lat : String
    var long : String
    var locality : String
    var country : String
}
