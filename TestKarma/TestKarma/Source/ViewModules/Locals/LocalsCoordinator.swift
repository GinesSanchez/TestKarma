//
//  LocalsCoordinator.swift
//  TestKarma
//
//  Created by Gines Sanchez Merono on 2020-06-11.
//  Copyright © 2020 Ginés Sanchez. All rights reserved.
//

import UIKit

protocol LocalsCoordinatorType: Coordinating { }


final class LocalsCoordinator: LocalsCoordinatorType {

    var navigationController: UINavigationController
    let viewModuleFactory: ViewModuleFactoryType
    private var localsViewController: LocalsViewController?
    private var detailViewController: LocalDetailViewController?

    init(navigationController: UINavigationController, viewModuleFactory: ViewModuleFactoryType) {
        self.navigationController = navigationController
        self.viewModuleFactory = viewModuleFactory
    }

    func start() {
        localsViewController = viewModuleFactory.createLocalsViewModule(coordinator: self)
        navigationController.pushViewController(localsViewController!, animated: true)
    }

    func stop() {
        self.navigationController .popViewController(animated: true)
        localsViewController = nil
    }
}

extension LocalsCoordinator: LocalViewModelCoordinatorDelegate {

    func showDetailsFor(local: Local) {
        detailViewController = viewModuleFactory.createDetailViewModule(local: local)
        navigationController.pushViewController(detailViewController!, animated: true)
    }
}

extension LocalsCoordinator: DetailViewModelCoordinatorDelegate {

    func goBackButtonTapped() {
        navigationController.popViewController(animated: true)
        detailViewController = nil
    }
}
