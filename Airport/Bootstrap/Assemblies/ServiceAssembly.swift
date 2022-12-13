//
//  ServiceAssembly.swift
//  Airport
//
//  Created by dohg on 07/12/2022.
//

import Swinject
import SwinjectAutoregistration

class ServiceAssembly: Assembly {
    
    func assemble(container: Container) {
        container.autoregister(AirportServiceProtocol.self,
                               initializer: AirportService.init)
    }
    
}

