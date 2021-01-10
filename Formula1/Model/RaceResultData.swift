//
//  RaceResultData.swift
//  Formula1
//
//  Created by Christian Kabouchy on 10/01/2021.
//

import Foundation

struct RaceResultData : Decodable {
    var MRData : MRDataRes
}
struct MRDataRes : Decodable {
    var RaceTable : RaceTableRes
}
struct RaceTableRes : Decodable {
    var season : String
    var round : String
    var Races : [RacesRes]
}
struct RacesRes : Decodable {
    var raceName : String
    var Circuit : CircuitRes
    var date : String
    var time : String
    var Results : [ResultsRes]
}
struct CircuitRes : Decodable {
    var circuitName : String
    var Location : LocationRes
}
struct LocationRes : Decodable{
    var locality : String
    var country : String
}
struct ResultsRes : Decodable {
    var number : String
    var position : String
    var points : String
    var Driver : DriverRes
    var Constructor : ConstructorRes
    var grid : String
    var laps : String
    var status : String
    var Time : TimeRes?
    var FastestLap : FastestLapRes?
    
}
struct DriverRes : Decodable {
    var code : String
    var givenName : String
    var familyName : String
    var nationality : String
}
struct ConstructorRes : Decodable {
    var name : String
}
struct TimeRes : Decodable {
    var time : String
}
struct FastestLapRes : Decodable {
    var rank : String
    var Time : TimeRes
}
