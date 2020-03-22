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

    @IBOutlet var tableView: UITableView!
    
    var pairs: [ExchangePairView] = [] {
        didSet { tableView.reloadData() }
    }
    
    var screenModel: RatesScreenModel = .empty {
        didSet{ uploadScreen(state: screenModel) }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.pairs.bind { [unowned self] pairs in
            self.pairs = pairs
        }
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: RatesCell.self)
    }
    
    private func uploadScreen(state: RatesScreenModel) {
        switch state {
        case .empty:
            print("Empty")
        case .rates(let pairs):
            print(pairs)
        }
    }
}

extension RatesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pairs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RatesCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configureCell(pairs[indexPath.row])
        return cell
    }
}

extension RatesViewController: UITableViewDelegate {

}

enum RatesScreenModel {
    case empty
    case rates([String])
}
