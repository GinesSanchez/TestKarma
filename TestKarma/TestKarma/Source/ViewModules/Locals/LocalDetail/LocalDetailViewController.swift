//
//  LocalDetailViewController.swift
//  TestKarma
//
//  Created by Gines Sanchez Merono on 2020-06-18.
//  Copyright © 2020 Ginés Sanchez. All rights reserved.
//

import UIKit

protocol LocalDetailViewControllerDelegate: class {
    func viewDidLoad()
}

final class LocalDetailViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!

    var viewModel: LocalDetailViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel?.viewDidLoad()
    }
}

extension LocalDetailViewController: LocalDetailViewModelDelegate {

    func updateDetailWith(local: Local) {
        messageLabel.text = local.description
    }
}
