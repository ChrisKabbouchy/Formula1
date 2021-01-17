//
//  newsData.swift
//  Formula1
//
//  Created by Christian Kabouchy on 15/01/2021.
//

import Foundation

struct NewsData : Decodable {
    
    var status : String?
    var totalResults : Int?
    var articles : [articlesData]?
}

struct articlesData : Decodable{
    
    var source : sourceData
    var author : String?
    var title : String?
    var description : String?
    var url : String?
    var urlToImage : String?
    var publishedAt : String?
    var content : String?
    
}

struct sourceData : Decodable {
    
    var id : String?
    var name : String?
}
