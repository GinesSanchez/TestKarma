//
//  LocalsViewController.swift
//  TestKarma
//
//  Created by Gines Sanchez Merono on 2020-06-11.
//  Copyright © 2020 Ginés Sanchez. All rights reserved.
//

import UIKit

protocol LocalsViewControllerDelegate: class {
    func viewDidLoad()
    //TODO:
}

final class LocalsViewController: UIViewController {

    var viewModel: LocalsViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        //TODO: Add set up

        viewModel?.viewDidLoad()
    }
}

extension LocalsViewController: LocalsViewModelDelegate {
    func viewModel(_ viewModel: LocalsViewModelType, stateDidChange state: ViewModelState<LocalsViewModelReadyState>) {
        switch state {
        case .empty:
            //TODO:
            break
        case .loading:
            //TODO:
            break
        case .initialized:
            //TODO:
            break
        case .failure(let error):
            //TODO:
            break
        case .ready(let readyState):
            //TODO:
            break
        }
    }
}
