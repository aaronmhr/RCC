//
//  RatesViewControllerTests.swift
//  RCC
//
//  Created by Aaron Huánuco on 25/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import XCTest
import SnapshotTesting
import Presentation
import Converter
@testable import RCC

final class RatesViewControllerTests: XCTestCase {
    func testThereNoDataFromViewModel_itSHouldNotDisplayAnyCurrency() {
        let (sut, viewModel) = makeSUT()
        
        viewModel.currenciesStub = []
        
        assertSnapshot(matching: sut, as: .image)
    }
    
    func testThereACurrencyFromViewModel_itSHouldBeDisplayed() {
        let (sut, viewModel) = makeSUT()
        
        viewModel.currenciesStub = [CurrencyView.euro]
        
        assertSnapshot(matching: sut, as: .image)
    }
    
    func testCurrenciesFromViewModel_itSHouldBeDisplayed() {
        let (sut, viewModel) = makeSUT()
        
        viewModel.currenciesStub = [CurrencyView.euro, CurrencyView.dollar, CurrencyView.pound]
        
        assertSnapshot(matching: sut, as: .image)
    }
    
    func testCurrenciesFromViewModel_inactivatedCurrenciesShouldRenderDiferently() {
        let (sut, viewModel) = makeSUT()
        
        viewModel.currenciesStub = [CurrencyView.euro, CurrencyView.dollarInactive, CurrencyView.pound]
        
        assertSnapshot(matching: sut, as: .image)
    }
}

private extension RatesViewControllerTests {
    func makeSUT() -> (CurrenciesViewController, CurrenciesViewModelMock) {
        let sut = CurrenciesViewController.viewController
        let viewModel = CurrenciesViewModelMock()
        sut.viewModel = viewModel
        return (sut, viewModel)
    }
}

extension CurrenciesViewController: StoryboardInstantiator {
    static var viewController: CurrenciesViewController {
        return defaultViewController(for: CurrenciesViewController.self)
    }
}

private final class CurrenciesViewModelMock: CurrenciesViewModel {
    var currenciesStub: [CurrencyView]!
    
    var currencies: Box<[CurrencyView]> = Box([])
    
    func loadCurrencies() {
        currencies.value = currenciesStub
    }
    
    func didSelectCurrencyAtIndex(_ index: Int) { }
}

extension CurrencyView {
    static let euro = CurrencyView.make(from: Currency.euro, isActive: true)
    static let euroInactive = CurrencyView.make(from: Currency.euro, isActive: false)
    static let dollar = CurrencyView.make(from: Currency.dollar, isActive: true)
    static let dollarInactive = CurrencyView.make(from: Currency.dollar, isActive: false)
    static let pound = CurrencyView.make(from: Currency.pound, isActive: true)
    static let poundInactive = CurrencyView.make(from: Currency.pound, isActive: false)
}
