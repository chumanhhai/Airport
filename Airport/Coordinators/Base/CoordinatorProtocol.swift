//
//  CoordinatorProtocol.swift
//  Airport
//
//  Created by dohg on 06/12/2022.
//

protocol CoordinatorProtocol: AnyObject {
    
    var childCoordinators: [CoordinatorProtocol] { get set }
    
    func start()
    
}

extension CoordinatorProtocol {
    
    func add(_ coordinator: CoordinatorProtocol) {
        childCoordinators.append(coordinator)
    }
    
    func remove(_ coordinator: CoordinatorProtocol) {
        childCoordinators = childCoordinators.filter( { $0 !== coordinator})
    }
    
}

