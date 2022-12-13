//
//  AirportDetailAssembly.swift
//  Airport
//
//  Created by dohg on 13/12/2022.
//

import Swinject

class AirportDetailAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(AirportDetailViewModelProtocol.self) { (r, airport: Airport) in
            return AirportDetailViewModel(withAirport: airport)
        }
        
        container.register(AirportDetailViewController.self) { (r, airport: Airport) in
            let viewModel = r.resolve(AirportDetailViewModelProtocol.self, argument: airport)!
            return AirportDetailViewController(withViewModel: viewModel)   
        }
    }
    
}
