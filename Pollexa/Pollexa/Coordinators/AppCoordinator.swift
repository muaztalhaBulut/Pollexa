//
//  AppCoordinator.swift
//  Pollexa
//
//  Created by Eda Bulut on 8.06.2024.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}

class AppCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let discoverCoordinator = DiscoverCoordinator(navigationController: navigationController)
        childCoordinators.append(discoverCoordinator)
        discoverCoordinator.start()
    }
}

