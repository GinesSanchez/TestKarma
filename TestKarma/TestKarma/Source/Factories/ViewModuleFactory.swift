//
//  ViewModuleFactory.swift
//  TestKarma
//
//  Created by Gines Sanchez Merono on 2020-06-11.
//  Copyright © 2020 Ginés Sanchez. All rights reserved.
//

import Foundation

protocol ViewModuleFactoryType {
    func createLocalsViewModule(coordinator: LocalViewModelCoordinatorDelegate) -> LocalsViewController
    func createDetailViewModule(local: Local) -> LocalDetailViewController
}

final class ViewModuleFactory: ViewModuleFactoryType {
    func createLocalsViewModule(coordinator: LocalViewModelCoordinatorDelegate) -> LocalsViewController {
        let viewController: LocalsViewController = LocalsViewController(nibName: "LocalsViewController", bundle: nil)
        let viewModel: LocalsViewModel = LocalsViewModel(localManager: LocalManager(networkManager: NetworkManager()),
                                                         delegate: viewController,
                                                         coordinator: coordinator)
        viewController.viewModel = viewModel
        return viewController
    }

    func createDetailViewModule(local: Local) -> LocalDetailViewController {
        let viewController: LocalDetailViewController = LocalDetailViewController(nibName: "LocalDetailViewController", bundle: nil)
        let viewModel: LocalDetailViewModel = LocalDetailViewModel(local: local, delegate: viewController)
        viewController.viewModel = viewModel
        return viewController
    }
}
