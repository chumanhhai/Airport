//
//  SearchCityCellViewModel.swift
//  Airport
//
//  Created by dohg on 07/12/2022.
//

import Foundation

protocol SearchCityCellViewModelProtocol {
    
    var city: String { get }
    var location: String { get }
    
}

struct SearchCityCellViewModel: SearchCityCellViewModelProtocol, Hashable {
    
    let city: String
    let location: String
    
    init(fromAirport airport: Airport) {
        city = airport.city
        location = "\(airport.state), \(airport.country)"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(city)
    }
    
}
