//
//  ConstructorStandingsData.swift
//  Formula1
//
//  Created by Christian Kabouchy on 11/19/20.
//

import Foundation

struct ConstructorStandingsData : Decodable {
    var MRData : MRDataC
}
struct MRDataC : Decodable {
    var StandingsTable : ConstructorStandingsTable
}
struct ConstructorStandingsTable : Decodable {
    var season : String
    var StandingsLists : [ConstructorStandingsLists]
}
struct ConstructorStandingsLists : Decodable {
    var season : String
    var round : String
    var ConstructorStandings : [ConstructorStandings]
}
struct ConstructorStandings : Decodable {
    var position : String
    var points : String
    var wins : String
    var Constructor : Constructor
}
struct Constructor :  Decodable {
    var name : String
    var nationality : String
}
