//
//  CurrenciesViewController.swift
//  RCC
//
//  Created by Aaron Huánuco on 21/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import UIKit

final class CurrenciesViewController: UIViewController {
    var viewModel: CurrenciesViewModelProtocol!
    
    @IBOutlet private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension CurrenciesViewController {

}

import Presentation
import Converter

public protocol CurrenciesViewModelProtocol {
    var currencies: Box<[String]> { get }
    func didSelctCurrencyAtIndex(_ index: Int)
}

public final class FirstCurrencyViewModel {
    private let currencyProvider: CurrencyProvider
    public private(set) var currencies: Box<[String]> = Box([])
    
    init(currencyProvider: CurrencyProvider) {
        self.currencyProvider = currencyProvider
    }
}

extension FirstCurrencyViewModel: CurrenciesViewModelProtocol {
    public func didSelctCurrencyAtIndex(_ index: Int) {
        
    }
}

