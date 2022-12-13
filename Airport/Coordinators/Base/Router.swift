//
//  Router.swift
//  Airport
//
//  Created by dohg on 12/12/2022.
//

import UIKit

typealias RoutingBackClosure = () -> Void

protocol Routing {
    
    func push(_ viewController: UIViewController, isAnimated: Bool, onBack: RoutingBackClosure?)
    
    func pop(_ isAnimated: Bool)
    
    func present(_ viewController: UIViewController, isAnimated: Bool, onBack: RoutingBackClosure?)
    
    func dismiss(_ isAnimated: Bool)
    
}

class Router: NSObject, Routing {

    private let navigationController: UINavigationController
    private var backClosures: [String: RoutingBackClosure?] = [:]
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
        self.navigationController.delegate = self
    }
    
    func push(_ viewController: UIViewController, isAnimated: Bool, onBack: RoutingBackClosure?) {
        backClosures[viewController.description] = onBack
        navigationController.pushViewController(viewController, animated: isAnimated)
    }
    
    func pop(_ isAnimated: Bool) {
        navigationController.popViewController(animated: isAnimated)
    }
    
    func present(_ viewController: UIViewController, isAnimated: Bool, onBack: RoutingBackClosure?) {
        backClosures[viewController.description] = onBack
        navigationController.present(viewController, animated: isAnimated)
        viewController.presentationController?.delegate = self
    }
    
    func dismiss(_ isAnimated: Bool) {
        navigationController.dismiss(animated: isAnimated)
    }
    
}

extension Router {
    
    private func executeClosure(_ key: String) {
        if let closure = backClosures[key] {
            closure?()
        }
    }
    
}

extension Router: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let previousViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
              !navigationController.viewControllers.contains(previousViewController) else { return }
        executeClosure(previousViewController.description)
    }
    
}

extension Router: UIAdaptivePresentationControllerDelegate {
    
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        executeClosure(presentationController.presentedViewController.description)
    }
    
}
