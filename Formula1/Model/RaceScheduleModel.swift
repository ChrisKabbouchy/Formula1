//
//  RaceScheduleModel.swift
//  Formula1
//
//  Created by Christian Kabouchy on 11/22/20.
//

import Foundation
struct RaceScheduleModel {
    var season : String
    var racesInfoList : [racesInfoList]
}
struct racesInfoList {
    var round : String
    var raceName : String
    var circuitName : String
    var country : String
    var locality : String
    var date : String
    var time : String
    var lat : String
    var long : String
}
