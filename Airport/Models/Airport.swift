//
//  Airport.swift
//  Airport
//
//  Created by dohg on 07/12/2022.
//

import SwiftyJSON

struct Airport: Equatable {
    
    let name: String
    let lat: Double
    let long: Double
    let city: String
    let state: String
    let country: String
    let runwayLength: Int
    
    init(name: String = "",
         lat: Double = 0,
         long: Double = 0,
         city: String = "",
         state: String = "",
         country: String = "",
         runwayLength: Int = 0) {
        self.name = name
        self.lat = lat
        self.long = long
        self.city = city
        self.state = state
        self.country = country
        self.runwayLength = runwayLength
    }
    
    init(withJson json: JSON) {
        name = json["name"].stringValue
        lat = json["lat"].doubleValue
        long = json["lon"].doubleValue
        city = json["city"].stringValue
        state = json["state"].stringValue
        country = json["country"].stringValue
        runwayLength = json["runway_length"].intValue
    }
    
}
