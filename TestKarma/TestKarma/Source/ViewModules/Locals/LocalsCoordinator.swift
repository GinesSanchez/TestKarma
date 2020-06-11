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

    init(navigationController: UINavigationController, viewModuleFactory: ViewModuleFactoryType) {
        self.navigationController = navigationController
        self.viewModuleFactory = viewModuleFactory
    }

    func start() {
        localsViewController = viewModuleFactory.createLocalsViewModule()
        navigationController.pushViewController(localsViewController!, animated: true)
    }

    func stop() {
        self.navigationController .popViewController(animated: true)
        localsViewController = nil
    }
}
