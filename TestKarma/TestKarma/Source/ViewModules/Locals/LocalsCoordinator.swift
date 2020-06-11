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
    private var localsViewController: LocalsViewController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        return
    }

    func start() {
        localsViewController = LocalsViewController.init(nibName: "LocalsViewController", bundle: nil)
        navigationController.pushViewController(localsViewController!, animated: true)
    }

    func stop() {
        self.navigationController .popViewController(animated: true)
        localsViewController = nil
    }
}
