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
    
    var cells: [String] = ["one", "two"]
    
    var screenModel: RatesScreenModel = .empty {
        didSet{ uploadScreen(state: screenModel) }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
    }
    
    @objc private func addTapped() {
        
    }
}

extension RatesViewController {
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
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
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell()
        cell.backgroundColor = .systemPink
        cell.textLabel?.text = cells[indexPath.row]
        return cell
    }
}

extension RatesViewController: UITableViewDelegate {

}

enum RatesScreenModel {
    case empty
    case rates([String])
}
