//
//  LocalsViewModel.swift
//  TestKarma
//
//  Created by Gines Sanchez Merono on 2020-06-11.
//  Copyright © 2020 Ginés Sanchez. All rights reserved.
//

import Foundation

protocol LocalsViewModelDelegate: class {
    //TODO:
}

protocol LocalsViewModelType {
    var localManager: LocalManagerType { get }
    var delegate: LocalsViewModelDelegate? { get }
    init(localManager: LocalManagerType, delegate: LocalsViewModelDelegate)
}

final class LocalsViewModel: LocalsViewModelType {
    var localManager: LocalManagerType
    weak var delegate: LocalsViewModelDelegate?

    init(localManager: LocalManagerType, delegate: LocalsViewModelDelegate) {
        self.localManager = localManager
        self.delegate = delegate
    }
}

extension LocalsViewModel: LocalsViewControllerDelegate {
    func viewDidLoad() {
        //TODO:
    }
}
