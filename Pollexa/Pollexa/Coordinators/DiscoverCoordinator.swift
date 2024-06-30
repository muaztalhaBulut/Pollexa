//
//  DiscoverCoordinator.swift
//  Pollexa
//
//  Created by Eda Bulut on 8.06.2024.
//

import UIKit

class DiscoverCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let dataService = MockDataService()
        let viewModel = DiscoverViewModel(dataService: dataService)
        let coordinator = DiscoverCoordinator(navigationController: navigationController)
        let discoverViewController = DiscoverViewController(
            viewModel: viewModel,
            coordinator: coordinator
        )
        discoverViewController.coordinator = self
        navigationController.pushViewController(discoverViewController, animated: true)
    }

    func showPollDetails(poll: Poll) {
       // let pollDetailViewController = PollDetailViewController()
       // pollDetailViewController.poll = poll
       // navigationController.pushViewController(pollDetailViewController, animated: true)
    }
}
