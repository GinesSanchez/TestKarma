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
    func updateFollowingStateFor(indexPath: IndexPath)
}

final class LocalsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageLabel: UILabel!

    var viewModel: LocalsViewControllerDelegate?
    private var localsArray: [LocalUI] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()
        viewModel?.viewDidLoad()
    }
}

//MARK: - Set Up Methods
private extension LocalsViewController {

    func setUp() {
        setUpNavigationBar()
        setUpTableView()
    }

    func setUpNavigationBar() {
        title = "Locals"
    }

    func setUpTableView() {
        let nib = UINib(nibName: "LocalTableViewCell",bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "LocalCell")
        tableView.dataSource = self
        tableView.tableFooterView = UIView()    //Hide the extra empty cell divider lines
    }
}

//MARK: - UITableViewDataSource
extension LocalsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LocalTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "LocalCell") as! LocalTableViewCell
        cell.configure(with: localsArray[indexPath.row], delegate: self)
        return cell
    }
}

//MARK: - LocalsViewModelDelegate
extension LocalsViewController: LocalsViewModelDelegate {
    func viewModel(_ viewModel: LocalsViewModelType, stateDidChange state: ViewModelState<LocalsViewModelReadyState>) {
        switch state {
        case .empty:
            tableView.isHidden = true
            messageLabel.text = "No results."
        case .loading:
            tableView.isHidden = true
            messageLabel.text = "Loading..."
        case .initialized:
            break
        case .failure:
            tableView.isHidden = true
            messageLabel.text = "There was a problem. Try again later."
        case .ready(let readyState):
            tableView.isHidden = false
            switch readyState {
            case .localsArrayReady(let array):
                localsArray = array
                tableView.reloadData()
            }
        }
    }
}


extension LocalsViewController: LocalTableViewCellDelegate {
    func followingButtonTappedFor(cell: LocalTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        viewModel?.updateFollowingStateFor(indexPath: indexPath)
    }
}


