//
//  ConstructorStandingsModel.swift
//  Formula1
//
//  Created by Christian Kabouchy on 11/19/20.
//

import Foundation

struct ConstructorStandingsModel {
    var season : String
    var round : String
    var constructorsInfoList : [ConstructorsInfoList]
}
struct ConstructorsInfoList {
    var position : String
    var points : String
    var wins : String
    var constructorName : String
    var nationality : String
    
}
