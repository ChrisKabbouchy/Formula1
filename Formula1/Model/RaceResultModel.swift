//
//  RaceResultModel.swift
//  Formula1
//
//  Created by Christian Kabouchy on 10/01/2021.
//

import Foundation

struct RaceResultModel {
    var season : String
    var round : String
    var raceResultInfoList : [raceResultInfoList]
}
struct raceResultInfoList  {
    var position : String
    var points :  String
    var name :  String
    var lastName : String
    var code : String
    var nationality : String
    var raceName : String
    var circuitName : String
    var location : String
    var country : String
    var date : String
    var raceTime : String
    var grid : String
    var laps : String
    var status : String
    var lapTime : String
    var fastestLapTime : String
    var fastestLapRank : String
    var constructorName : String
}
