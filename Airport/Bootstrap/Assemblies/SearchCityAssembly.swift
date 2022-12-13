//
//  SearchCityAssembly.swift
//  Airport
//
//  Created by dohg on 06/12/2022.
//

import Swinject
import SwinjectAutoregistration

class SearchCityAssembly: Assembly {
    
    func assemble(container: Container) {
        container.autoregister(SearchCityViewModelProtocol.self,
                               initializer: SearchCityViewModel.init)
        
        container.autoregister(SearchCityViewController.self,
                               initializer: SearchCityViewController.init)
    }
    
}
