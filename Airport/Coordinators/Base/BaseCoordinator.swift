//
//  BaseCoordinator.swift
//  Airport
//
//  Created by dohg on 06/12/2022.
//

class BaseCoordinator: CoordinatorProtocol {
    
    var childCoordinators: [CoordinatorProtocol] = []
    
    func start() {
        fatalError("Child class must implement this function.")
    }
    
}

class BaseCoordinatorWithRouting: BaseCoordinator {
    
    let router: Routing
    var onBack: RoutingBackClosure? = nil
    
    init(router: Routing) {
        self.router = router
    }
    
}
