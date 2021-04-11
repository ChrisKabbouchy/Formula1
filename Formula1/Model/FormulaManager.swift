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
    func racesScheduleDataDidLoad(Races : RaceScheduleModel)
    func raceResultDataDidLoad (RaceResult : RaceResultModel)
    func newsDataDidLoad (newsModel : [NewsModel])
    func errorOccurred(error:Error)
    func noDataAvailable()
}
extension FormulaMangerDelegate {
    func driversDataDidLoad(Drivers : DriversStandingsModel){}
    func constructorDataDidLoad(Constructors: ConstructorStandingsModel){}
    func racesScheduleDataDidLoad(Races : RaceScheduleModel){}
    func raceResultDataDidLoad (RaceResult : RaceResultModel){}
    func newsDataDidLoad (newsModel : [NewsModel]){}
    func errorOccurred(error:Error){}
    func noDataAvailable(){}
}
struct FormulaManger {
    
    let driversUrl = "https://ergast.com/api/f1/2021/driverStandings.json"
    let constructorsUrl = "https://ergast.com/api/f1/2021/constructorStandings.json"
    let racesUrl = "https://ergast.com/api/f1/2021.json"
    let raceResultUrl = "https://ergast.com/api/f1/2021/"
    private let searchUrl = "https://newsapi.org/v2/everything?q=formula%201&apiKey=fcf0aefb55a24e739bbb8ea0b5edbad1"
    var delegate : FormulaMangerDelegate?
    
    //MARK: -Drivers data function
    func fetchStandingsData()  {
        
        if let url = URL(string: driversUrl){
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    print("error in task")
                    delegate?.errorOccurred(error: error!)
                    return
                }
                if let safeData = data{
                    let decoder = JSONDecoder()
                    do {
                        let decodedData = try decoder.decode(DriversStandingsData.self, from: safeData)
                        let driverIndex = decodedData.MRData.StandingsTable.StandingsLists[0].DriverStandings
                        var standingsList : [DriversInfoList] = []
                        for i in 0...decodedData.MRData.StandingsTable.StandingsLists[0].DriverStandings.count-1 {
                            
                            let driversList = DriversInfoList(
                                position: Int(driverIndex[i].position) ?? 0,
                                driverName: driverIndex[i].Driver.givenName,
                                driverLastName: driverIndex[i].Driver.familyName,
                                points: driverIndex[i].points,
                                driverNumber: driverIndex[i].Driver.permanentNumber,
                                nationality: driverIndex[i].Driver.nationality,
                                dateOfBirth: driverIndex[i].Driver.dateOfBirth,
                                constructor: driverIndex[i].Constructors[0].name,
                                permanentNumber: driverIndex[i].Driver.permanentNumber)
                            // print(driversList)
                            standingsList.append(driversList)
                        }
                        let driverModel = DriversStandingsModel(
                            season: decodedData.MRData.StandingsTable.StandingsLists[0].season,
                            round: decodedData.MRData.StandingsTable.StandingsLists[0].round,
                            driversInfoList: standingsList)
                        
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
                    delegate?.errorOccurred(error: error!)
                    return
                }
                if let safeData = data{
                    let decoder = JSONDecoder()
                    do {
                        let decodedData = try decoder.decode(ConstructorStandingsData.self, from: safeData)
                        let ConstructorIndex = decodedData.MRData.StandingsTable.StandingsLists[0].ConstructorStandings
                        var standingsList : [ConstructorsInfoList] = []
                        for i in 0...decodedData.MRData.StandingsTable.StandingsLists[0].ConstructorStandings.count-1 {
                            
                            let constructorList = ConstructorsInfoList(
                                position: ConstructorIndex[i].position,
                                points: ConstructorIndex[i].points,
                                wins: ConstructorIndex[i].wins,
                                constructorName: ConstructorIndex[i].Constructor.name,
                                nationality: ConstructorIndex[i].Constructor.nationality)
                            
                            standingsList.append(constructorList)
                        }
                        let constructorModel = ConstructorStandingsModel(
                            season: decodedData.MRData.StandingsTable.StandingsLists[0].season,
                            round: decodedData.MRData.StandingsTable.StandingsLists[0].round,
                            constructorsInfoList: standingsList)
                        
                        delegate?.constructorDataDidLoad(Constructors: constructorModel)
                    } catch  {
                        print("error in decoding data", error)
                    }
                    
                }
            }
            task.resume()
            
        }
    }
    
    //MARK: -Races data function
    func fetchRacesData(){
        if let url = URL(string: racesUrl){
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    print("error in task")
                    delegate?.errorOccurred(error: error!)
                    return
                }
                if let safeData = data{
                    let decoder = JSONDecoder()
                    do {
                        let decodedData = try decoder.decode(RaceScheduleData.self, from: safeData)
                        let racesIndex = decodedData.MRData.RaceTable.Races
                        var racesList : [racesInfoList] = []
                        for i in 0...decodedData.MRData.RaceTable.Races.count-1 {
                            
                            let racesInfo = racesInfoList(
                                round: racesIndex[i].round,
                                raceName: racesIndex[i].raceName,
                                circuitName: racesIndex[i].Circuit.circuitName,
                                country: racesIndex[i].Circuit.Location.country,
                                locality: racesIndex[i].Circuit.Location.locality,
                                date: racesIndex[i].date,
                                time: racesIndex[i].time ?? "0",
                                lat: racesIndex[i].Circuit.Location.lat,
                                long: racesIndex[i].Circuit.Location.long)
                            
                            racesList.append(racesInfo)
                        }
                        let racesModel = RaceScheduleModel(
                            season: decodedData.MRData.RaceTable.season,
                            racesInfoList: racesList)
                        
                        delegate?.racesScheduleDataDidLoad(Races: racesModel)
                    } catch  {
                        print(error)
                    }
                    
                }
            }
            task.resume()
            
        }
    }
    
    //MARK: -Races Result Data
    func fetchRaceResult(round : String){
        let finalUrl = "\(raceResultUrl)\(round)/results.json"
        if let url = URL(string: finalUrl){
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    print("error in task")
                    delegate?.errorOccurred(error: error!)
                    return
                }
                if let safeData = data{
                    let decoder = JSONDecoder()
                    do {
                        let decodedData = try decoder.decode(RaceResultData.self, from: safeData)
                        if let raceResultIndex = decodedData.MRData.RaceTable.Races.first {
                            var raceResultList : [raceResultInfoList] = []
                            for i in 0...decodedData.MRData.RaceTable.Races[0].Results.count-1 {
                                
                                let resultList = raceResultInfoList(
                                    position: raceResultIndex.Results[i].position,
                                    points: raceResultIndex.Results[i].points,
                                    name: raceResultIndex.Results[i].Driver.givenName,
                                    lastName: raceResultIndex.Results[i].Driver.familyName,
                                    code: raceResultIndex.Results[i].Driver.code,
                                    nationality: raceResultIndex.Results[i].Driver.nationality,
                                    raceName: raceResultIndex.raceName,
                                    circuitName: raceResultIndex.Circuit.circuitName,
                                    location: raceResultIndex.Circuit.Location.locality,
                                    country: raceResultIndex.Circuit.Location.country,
                                    date: raceResultIndex.date,
                                    raceTime: raceResultIndex.time,
                                    grid: raceResultIndex.Results[i].grid,
                                    laps: raceResultIndex.Results[i].laps,
                                    status: raceResultIndex.Results[i].status,
                                    lapTime: raceResultIndex.Results[i].Time?.time ?? "0",
                                    fastestLapTime: raceResultIndex.Results[i].FastestLap?.Time.time ?? "0",
                                    fastestLapRank: raceResultIndex.Results[i].FastestLap?.rank ?? "0",
                                    constructorName: raceResultIndex.Results[i].Constructor.name)
                                raceResultList.append(resultList)
                            }
                            let raceResultModel = RaceResultModel(
                                season: decodedData.MRData.RaceTable.season,
                                round: decodedData.MRData.RaceTable.round,
                                raceResultInfoList: raceResultList)
                            
                            delegate?.raceResultDataDidLoad(RaceResult: raceResultModel)
                        }else{
                            delegate?.noDataAvailable()
                        }
                        
                    } catch  {
                        print(error)
                    }
                    
                }
            }
            task.resume()
            
        }
        
    }
    //MARK: -News Data
    func fetchNews(){
        
        if let url = URL(string: searchUrl){
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            let session = URLSession(configuration: .default)
            
            let task =  session.dataTask(with: request) { (data, response, error) in
                if error != nil{
                    return
                }
                if let safeData = data{
                    let decoder = JSONDecoder()
                    do {
                        let decodedData = try decoder.decode(NewsData.self, from: safeData)
                        var newsModel = [NewsModel]()
                        for i in 0..<decodedData.articles!.count{
                            let currentItem = decodedData.articles![i]
                            let newNewsItem  = NewsModel(
                                id: i,
                                sourceName: currentItem.source.name,
                                title: currentItem.title,
                                description: currentItem.description,
                                imageUrl: currentItem.urlToImage,
                                newsUrl: currentItem.url,
                                date: currentItem.publishedAt,
                                author: currentItem.author,
                                content: currentItem.content)
                            newsModel.append(newNewsItem)
                        }
                        delegate?.newsDataDidLoad(newsModel: newsModel)
                    } catch  {
                        print(error)
                    }
                }
            }
            task.resume()
            
        }else{
            print(searchUrl)
        }
    }
}
