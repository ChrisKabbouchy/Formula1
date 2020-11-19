//
//  StandingsData.swift
//  Formula1
//
//  Created by Christian Kabouchy on 11/19/20.
//

import Foundation

struct DriversStandingsData : Decodable {
    var MRData : MRData
}
struct MRData : Decodable {
    var StandingsTable : StandingsTable
}
struct StandingsTable : Decodable {
    var season : String
    var StandingsLists : [StandingsLists]
}
struct StandingsLists : Decodable {
    var season : String
    var round : String
    var DriverStandings : [DriverStandings]
}
struct DriverStandings : Decodable {
    var position : String
    var points : String
    var wins : String
    var Driver : Driver
    var Constructors : [Constructors]
}
struct Driver : Decodable {
    var driverId : String
    var permanentNumber : String
    var code : String
    var givenName : String
    var familyName : String
    var dateOfBirth : String
    var nationality : String
}
struct Constructors : Decodable {
    var constructorId : String
    var name : String
    var nationality : String
}
