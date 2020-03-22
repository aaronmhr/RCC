//
//  CurrenciesViewController.swift
//  RCC
//
//  Created by Aaron Huánuco on 21/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import UIKit
import Presentation

final class CurrenciesViewController: UIViewController {
    
    var viewModel: CurrenciesViewModel?
    @IBOutlet private var tableView: UITableView!

    private var currencies: [CurrencyView] = [] {
        didSet { tableView.reloadData() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataSource()
        setupNavigationController()
        viewModel?.currencies.bind { [unowned self] currencies in
            self.currencies = currencies
        }
        viewModel?.loadCurrencies()
    }
}

extension CurrenciesViewController {
    private func setupDataSource() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(cellType: CurrencyCell.self)
    }
    
    private func setupNavigationController() {
        navigationController?.isNavigationBarHidden = true
    }
}

extension CurrenciesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CurrencyCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(with: currencies[indexPath.row])
        return cell
    }
}

extension CurrenciesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didSelectCurrencyAtIndex(indexPath.row)
    }
}
