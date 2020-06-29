//
//  LocalDetailViewModel.swift
//  TestKarma
//
//  Created by Gines Sanchez Merono on 2020-06-18.
//  Copyright © 2020 Ginés Sanchez. All rights reserved.
//

import Foundation

protocol LocalDetailViewModelDelegate: class {
    func updateDetailWith(local: Local)
}

protocol LocalDetailViewModelType {
    var delegate: LocalDetailViewModelDelegate? { get }
    var local: Local { get }
    init(local: Local, delegate: LocalDetailViewModelDelegate)
}

final class LocalDetailViewModel: LocalDetailViewModelType {
    weak var delegate: LocalDetailViewModelDelegate?
    let local: Local

    init(local: Local, delegate: LocalDetailViewModelDelegate) {
        self.local = local
        self.delegate = delegate
    }
}

extension LocalDetailViewModel: LocalDetailViewControllerDelegate {

    func viewDidLoad() {
        delegate?.updateDetailWith(local: local)
    }
}
