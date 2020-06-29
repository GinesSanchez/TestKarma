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

protocol LocalViewModelCoordinatorDelegate: class {
    func showDetailsFor(local: Local)
}

protocol LocalsViewModelType {
    var localManager: LocalManagerType { get }
    var delegate: LocalsViewModelDelegate? { get }
    var coordinator: LocalViewModelCoordinatorDelegate? { get }
    var state: ViewModelState<LocalsViewModelReadyState> { get }
    init(localManager: LocalManagerType, delegate: LocalsViewModelDelegate, coordinator: LocalViewModelCoordinatorDelegate)
}

final class LocalsViewModel: LocalsViewModelType {
    var localManager: LocalManagerType
    weak var delegate: LocalsViewModelDelegate?
    weak var coordinator: LocalViewModelCoordinatorDelegate?

    private var localUIArray: [LocalUI] = []
    private var localArray: [Local] = []

    var state: ViewModelState<LocalsViewModelReadyState> {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.delegate?.viewModel(self, stateDidChange: self.state)
            }
        }
    }

    init(localManager: LocalManagerType, delegate: LocalsViewModelDelegate, coordinator: LocalViewModelCoordinatorDelegate) {
        self.localManager = localManager
        self.delegate = delegate
        self.state = .initialized
        self.coordinator = coordinator
    }
}

// MARK: - LocalsViewControllerDelegate
extension LocalsViewModel: LocalsViewControllerDelegate {
    func viewDidLoad() {
        getLocals()
    }

    func updateFollowingStateFor(indexPath: IndexPath) {
        let local = localUIArray[indexPath.row]
        //TODO: Update array in Locals Service
        localUIArray[indexPath.row] = LocalUI(name: local.name, distance: local.distance, following: !local.following)
        self.state = .ready(.localsArrayReady(localUIArray))
    }

    func didSelectLocalAt(indexPath: IndexPath) {
        coordinator?.showDetailsFor(local: localArray[indexPath.row])
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

                self?.localArray = localArray.sorted {
                    $0.location.distance(from: officeLocation) < $1.location.distance(from: officeLocation)
                }

                let localUIArray = self?.localArray.map {
                    LocalUI(name: $0.name,
                            distance: String(format:"%.03f Km", $0.location.distance(from: officeLocation) / 1000),
                            following: $0.following)
                }
                self?.localUIArray = localUIArray!
                self?.state = .ready(.localsArrayReady(localUIArray!))
                break
            }
        }
    }
}
