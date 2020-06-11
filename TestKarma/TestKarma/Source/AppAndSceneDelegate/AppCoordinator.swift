//
//  AppCoordinator.swift
//  TestKarma
//
//  Created by Gines Sanchez Merono on 2020-06-11.
//  Copyright © 2020 Ginés Sanchez. All rights reserved.
//

import UIKit

protocol AppCoordinatorType: Coordinating { }

final class AppCoordinator: AppCoordinatorType {

    let navigationController: UINavigationController

    private var localsCoordinator: LocalsCoordinatorType?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        localsCoordinator = LocalsCoordinator(navigationController: self.navigationController)
        localsCoordinator?.start()
    }

    func stop() {
        localsCoordinator?.stop()
    }
}
