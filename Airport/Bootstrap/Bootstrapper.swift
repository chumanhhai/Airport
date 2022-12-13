//
//  Bootstrapper.swift
//  Airport
//
//  Created by dohg on 06/12/2022.
//

import Swinject

extension Container {
    
    static let shared: Container = {
        let container = Container()
        let assemblies: [Assembly] = [
            SearchCityAssembly(),
            AirportsAssembly(),
            AirportDetailAssembly(),
            ServiceAssembly()
        ]
        _ = Assembler(assemblies, container: container)
        
        return container
    }()
    
}
