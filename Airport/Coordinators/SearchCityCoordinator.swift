//
//  SearchCityCoordinator.swift
//  Airport
//
//  Created by dohg on 06/12/2022.
//

import Swinject
import UIKit
import RxSwift
import RxCocoa

class SearchCityCoordinator: BaseCoordinatorWithRouting {

    private let disposeBag = DisposeBag()
    
    override func start() {
        guard let vc = Container.shared.resolve(SearchCityViewController.self) else { return }
        vc.routingBuilder = { [unowned self] airportsDriver in
            airportsDriver.drive(onNext: { airports in
                self.navigateToAirportsViewController(airports)
            })
            .disposed(by: disposeBag)
        }
        router.push(vc, isAnimated: true, onBack: onBack)
    }
    
}

extension SearchCityCoordinator {
    
    private func navigateToAirportsViewController(_ airports: [Airport]) {
        let airportsCoordinator = AirportsCoordinator(router: router, airports: airports)
        airportsCoordinator.onBack = { [weak self, weak airportsCoordinator] in
            if let airportsCoordinator = airportsCoordinator {
                self?.remove(airportsCoordinator)
            }
        }
        add(airportsCoordinator)
        airportsCoordinator.start()
    }
    
}
