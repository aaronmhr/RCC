//
//  RatesViewController.swift
//  RCC
//
//  Created by Aaron Huánuco on 17/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import UIKit
import Presentation

final class RatesViewController: UIViewController {
    var viewModel: RatesViewModel!
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var addPairView: AddPairView!
    @IBOutlet private var addPairViewHeight: NSLayoutConstraint!
    
    var pairs: [ExchangePairView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        addPairView.addAction { [weak self] in
            self?.viewModel.addPairDidTapp()
        }
        viewModel.pairs.bind { [unowned self] pairs in
            self.pairs = pairs
            self.tableView.reloadData()
        }
        viewModel.newPair.bind { [unowned self] newPair in
            guard let pair = newPair else { return }
            self.pairs.insert(pair, at: 0)
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
            self.tableView.endUpdates()
        }
        viewModel.isEmptyScreen.bind { [unowned self] isEmpty in
            let newHeight = isEmpty ? UIScreen.main.bounds.height : 70
            guard self.addPairViewHeight.constant != newHeight else { return }
            UIView.animate(withDuration: 0.4) {
                self.addPairViewHeight.constant = newHeight
                self.addPairView.state = AddPairView.State.configured
                self.addPairView.state = isEmpty ? AddPairView.State.empty : AddPairView.State.configured
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.startFetchingExchangeRates()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.stopFetchingExchangeRates()
    }
    
    @objc private func addTapped() {
        viewModel.addPairDidTapp()
    }
}

extension RatesViewController {
    private func setupNavigationBar() {
        navigationController?.navigationBar.style = NavigationBarStyles.main
        title = viewModel.title
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(cellType: RatesCell.self)
    }
}

extension RatesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pairs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RatesCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configureCell(pairs[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        viewModel.startFetchingExchangeRates()
    }
    
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        viewModel.stopFetchingExchangeRates()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pairs.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            viewModel.deletePairAtIndex(indexPath.row)
        }
    }
}
