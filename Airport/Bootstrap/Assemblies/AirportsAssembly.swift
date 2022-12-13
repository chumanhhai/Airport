//
//  AirportsAssembly.swift
//  Airport
//
//  Created by dohg on 10/12/2022.
//

import Swinject
import SwinjectAutoregistration

class AirportsAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(AirportsViewModelProtocol.self) { (r, airports: [Airport]) in
            AirportsViewModel(airports: airports)
        }
        
        container.register(AirportsViewController.self) { (r, airports: [Airport]) in
            let viewModel = r.resolve(AirportsViewModelProtocol.self, argument: airports)!
            return AirportsViewController(viewModel: viewModel)
        }
    }
    
}

