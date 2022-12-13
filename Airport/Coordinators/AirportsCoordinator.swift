//
//  AirportsCoordinator.swift
//  Airport
//
//  Created by dohg on 10/12/2022.
//

import UIKit
import Swinject
import SwinjectAutoregistration
import RxSwift

class AirportsCoordinator: BaseCoordinatorWithRouting {
    
    private let airports: [Airport]
    private let disposeBag = DisposeBag()
    
    init(router: Routing, airports: [Airport]) {
        self.airports = airports
        super.init(router: router)
    }
    
    override func start() {
        guard let vc = Container.shared.resolve(AirportsViewController.self, argument: airports)
            else { return }
        vc.routingBuilder = { [weak self] airportSelect in
            guard let self = self else { return }
            airportSelect.drive(onNext: {
                self.showAirportDetail($0)
            })
            .disposed(by: self.disposeBag)
        }
        router.push(vc, isAnimated: true, onBack: onBack)
    }
}

extension AirportsCoordinator {
    
    private func showAirportDetail(_ airport: Airport) {
        let coordinator = AirportDetailCoordinator(router: router, airport: airport)
        coordinator.onBack = { [weak self, weak coordinator] in
            guard let self = self, let coordinator = coordinator else { return }
            self.remove(coordinator)
        }
        add(coordinator)
        coordinator.start()
    }
    
}
