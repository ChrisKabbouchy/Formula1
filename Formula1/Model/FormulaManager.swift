//
//  FormulaManager.swift
//  Formula1
//
//  Created by Christian Kabouchy on 11/19/20.
//

import Foundation

protocol FormulaMangerDelegate {
    func driversDataDidLoad(Drivers : DriversStandingsModel)
    func constructorDataDidLoad(Constructors: ConstructorStandingsModel)
    func errorOccurred(error:Error)
}
struct FormulaManger {
    
    let driversUrl = "https://ergast.com/api/f1/current/driverStandings.json"
    let constructorsUrl = "https://ergast.com/api/f1/current/constructorStandings.json"
    var delegate : FormulaMangerDelegate?
    
    //MARK: -Drivers data function
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
                        delegate?.driversDataDidLoad(Drivers: driverModel)
                    } catch  {
                        print(error)
                    }
                    
                }
            }
            task.resume()
            
        }
    }
    //MARK: -Constructor data function
    func fetchConstructorData() {
        if let url = URL(string: constructorsUrl){
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    print("error in task")
                    return
                }
                if let safeData = data{
                    let decoder = JSONDecoder()
                    do {
                        let decodedData = try decoder.decode(ConstructorStandingsData.self, from: safeData)
                        let ConstructorIndex = decodedData.MRData.StandingsTable.StandingsLists[0].ConstructorStandings
                        var standingsList : [ConstructorsInfoList] = []
                        for i in 0...decodedData.MRData.StandingsTable.StandingsLists[0].ConstructorStandings.count-1 {
                            
                            let constructorList = ConstructorsInfoList(position: Int(ConstructorIndex[i].position)!, points: ConstructorIndex[i].points, wins: ConstructorIndex[i].wins, constructorName: ConstructorIndex[i].Constructor.name, nationality: ConstructorIndex[i].Constructor.nationality)
                            standingsList.append(constructorList)
                        }
                        let constructorModel = ConstructorStandingsModel(season: decodedData.MRData.StandingsTable.StandingsLists[0].season, round: decodedData.MRData.StandingsTable.StandingsLists[0].round, constructorsInfoList: standingsList)
                        print(constructorModel)
                    } catch  {
                        print(error)
                    }
                    
                }
            }
            task.resume()
            
        }
    }
}
