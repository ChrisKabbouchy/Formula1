//
//  FormulaManager.swift
//  Formula1
//
//  Created by Christian Kabouchy on 11/19/20.
//

import Foundation

struct FormulaManger {
    let driversUrl = "https://ergast.com/api/f1/current/driverStandings.json"
    let constructorsUrl = "https://ergast.com/api/f1/current/constructorStandings.json"
    
    func fetchStandingsData()  {
        
        if let url = URL(string: driversUrl){
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    print("error in task")
                    return
                }
                if let safeData = data{
                    let decoder = JSONDecoder()
                    do {
                        let decodedData = try decoder.decode(DriversStandingsData.self, from: safeData)
                        let driverIndex = decodedData.MRData.StandingsTable.StandingsLists[0].DriverStandings
                        var standingsList : [DriversInfoList] = []
                        for i in 0...decodedData.MRData.StandingsTable.StandingsLists[0].DriverStandings.count-1 {
                            
                            let driversList = DriversInfoList(position: Int(driverIndex[i].position)!, driverName: driverIndex[i].Driver.givenName, driverLastName: driverIndex[i].Driver.familyName, points: driverIndex[i].points, driverNumber: driverIndex[i].Driver.permanentNumber, nationality: driverIndex[i].Driver.nationality, dateOfBirth: driverIndex[i].Driver.dateOfBirth, constructor: driverIndex[i].Constructors[0].nationality)
                            standingsList.append(driversList)
                        }
                        let driverModel = DriversStandingsModel(season: decodedData.MRData.StandingsTable.StandingsLists[0].season, round: decodedData.MRData.StandingsTable.StandingsLists[0].round, driversInfoList: standingsList)
                        print(driverModel)
                    } catch  {
                        print(error)
                    }
                    
                }
            }
            task.resume()
            
        }
    }
}
