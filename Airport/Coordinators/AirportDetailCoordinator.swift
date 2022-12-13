//
//  AirportDetailCoordinator.swift
//  Airport
//
//  Created by dohg on 13/12/2022.
//

import Swinject

class AirportDetailCoordinator: BaseCoordinatorWithRouting {
    
    private let airport: Airport
    
    init(router: Routing, airport: Airport) {
        self.airport = airport
        super.init(router: router)
    }
    
    override func start() {
        guard let vc = Container.shared.resolve(AirportDetailViewController.self, argument: airport)
        else { return }
        router.present(vc, isAnimated: true, onBack: onBack)
    }
    
}
