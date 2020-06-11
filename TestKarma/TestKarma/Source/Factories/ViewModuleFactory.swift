//
//  ViewModuleFactory.swift
//  TestKarma
//
//  Created by Gines Sanchez Merono on 2020-06-11.
//  Copyright © 2020 Ginés Sanchez. All rights reserved.
//

import Foundation

protocol ViewModuleFactoryType {
    func createLocalsViewModule() -> LocalsViewController
}

final class ViewModuleFactory: ViewModuleFactoryType {
    func createLocalsViewModule() -> LocalsViewController {
        let viewController: LocalsViewController = LocalsViewController.init(nibName: "LocalsViewController", bundle: nil)
        let viewModel: LocalsViewModel = LocalsViewModel(localManager: LocalManager(networkManager: NetworkManager()),
                                                         delegate: viewController)
        viewController.viewModel = viewModel
        return viewController
    }
}
