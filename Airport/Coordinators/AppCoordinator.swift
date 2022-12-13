//
//  AppCoordinator.swift
//  Airport
//
//  Created by dohg on 06/12/2022.
//

import Swinject

class AppCoordinator: BaseCoordinator {
    
    private let window: UIWindow
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        let navigationBar = navigationController.navigationBar
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .primaryRed
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 24)]
        appearance.shadowColor = .clear
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.tintColor = .white
        return navigationController
    }()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        let router = Router(navigationController: navigationController)
        let searchCityCoordinator = SearchCityCoordinator(router: router)
        add(searchCityCoordinator)
        searchCityCoordinator.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
}

