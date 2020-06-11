//
//  LocalsViewModel.swift
//  TestKarma
//
//  Created by Gines Sanchez Merono on 2020-06-11.
//  Copyright © 2020 Ginés Sanchez. All rights reserved.
//

import Foundation
import CoreLocation

private let officeLocation = CLLocation(latitude: 59.330596, longitude: 18.0560967)

enum LocalsViewModelReadyState {
    case localsArrayReady([LocalUI])
}

protocol LocalsViewModelDelegate: class {
    func viewModel(_ viewModel: LocalsViewModelType, stateDidChange state: ViewModelState<LocalsViewModelReadyState>)
}

protocol LocalsViewModelType {
    var localManager: LocalManagerType { get }
    var delegate: LocalsViewModelDelegate? { get }
    var state: ViewModelState<LocalsViewModelReadyState> { get }
    init(localManager: LocalManagerType, delegate: LocalsViewModelDelegate)
}

final class LocalsViewModel: LocalsViewModelType {
    var localManager: LocalManagerType
    weak var delegate: LocalsViewModelDelegate?

    private var localUIArray: [LocalUI] = []

    var state: ViewModelState<LocalsViewModelReadyState> {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.delegate?.viewModel(self, stateDidChange: self.state)
            }
        }
    }

    init(localManager: LocalManagerType, delegate: LocalsViewModelDelegate) {
        self.localManager = localManager
        self.delegate = delegate
        self.state = .initialized
    }
}

// MARK: - LocalsViewControllerDelegate
extension LocalsViewModel: LocalsViewControllerDelegate {
    func viewDidLoad() {
        getLocals()
    }

    func updateFollowingStateFor(indexPath: IndexPath) {
        let local = localUIArray[indexPath.row]
        localUIArray[indexPath.row] = LocalUI(name: local.name, distance: local.distance, following: !local.following)
        self.state = .ready(.localsArrayReady(localUIArray))
    }
}

// MARK: - Helper functions
private extension LocalsViewModel {
    func getLocals() {
        state = .loading
        localManager.getLocals { [weak self] (result) in
            switch result {
            case .failure(let error):
                self?.state = .failure(error)
            case .success(let localArray):
                guard localArray.count > 0 else {
                    self?.state = .empty
                    return
                }

                let sortedLocalArray = localArray.sorted {
                    $0.location.distance(from: officeLocation) < $1.location.distance(from: officeLocation)
                }

                let localUIArray = sortedLocalArray.map {
                    LocalUI(name: $0.name,
                            distance: String(format:"%.03f Km", $0.location.distance(from: officeLocation) / 1000),
                            following: $0.following)
                }
                self?.localUIArray = localUIArray
                self?.state = .ready(.localsArrayReady(localUIArray))
                break
            }
        }
    }
}
