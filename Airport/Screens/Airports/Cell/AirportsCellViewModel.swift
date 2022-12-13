//
//  AirportsCellViewModel.swift
//  Airport
//
//  Created by dohg on 10/12/2022.
//

import CoreLocation

protocol AirportsCellViewModelProtocol {
    
    var name: String { get }
    var distance: String { get }
    var runwayLength: String { get }
    
}

struct AirportsCellViewModel: AirportsCellViewModelProtocol {
    
    let airport: Airport
    let currentLocation: CLLocation?
    
    var name: String {
        airport.name
    }
    
    var distance: String {
        guard let currentLocation = currentLocation else {
            return "Distance: unknown"
        }
        let airportLocation = CLLocation(latitude: airport.lat, longitude: airport.long)
        return "Distance: \((airportLocation.distance(from: currentLocation)/1000).rounded()) km"
    }
    
    var runwayLength: String {
        "Runway length: \(airport.runwayLength) m"
    }
    
}
