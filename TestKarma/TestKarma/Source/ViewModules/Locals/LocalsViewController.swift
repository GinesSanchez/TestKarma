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
    //TODO:
}
