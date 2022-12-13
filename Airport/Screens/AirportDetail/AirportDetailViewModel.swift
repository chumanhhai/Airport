//
//  AirportDetailViewModel.swift
//  Airport
//
//  Created by dohg on 13/12/2022.
//

import Foundation

protocol AirportDetailViewModelProtocol {
    
    var airportName: String { get }
    
}

class AirportDetailViewModel: AirportDetailViewModelProtocol {
    
    private let airport: Airport
    
    var airportName: String {
        airport.name
    }
    
    init(withAirport airport: Airport) {
        self.airport = airport
    }
    
}
