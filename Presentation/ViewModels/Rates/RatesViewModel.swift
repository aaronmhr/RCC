//
//  RatesViewModel.swift
//  Presentation
//
//  Created by Aaron Huánuco on 17/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import Converter

public final class RatesViewModel {
    private let pairUseCase: PairInteractorProtocol
    private let exchangePairProvider: ExchangePairProvider
    public var router: RatesRouterProtocol?
    private var previouslyRetrievedPairs = 0
    
    public init(pairUseCase: PairInteractorProtocol, exchangePairProvider: ExchangePairProvider) {
        self.pairUseCase = pairUseCase
        self.exchangePairProvider = exchangePairProvider
    }
    
    private var pairsModel: [Pair] = []
    public private(set) var pairs: Box<[ExchangePairView]> = Box([])
    public private(set) var newPair: Box<ExchangePairView?> = Box(nil)
    public private(set) var isEmptyScreen: Box<Bool> = Box(true) {
        willSet {
            guard isEmptyScreen.value else { return }
            stopFetchingExchangeRates()
        }
    }
    public var title: String {
        return Localizables.title
    }
    
    public func startFetchingExchangeRates() {
        pairUseCase.getConfiguredPairs { [weak self] result in
            switch result {
            case .success(let pairs):
                self?.pairsModel = pairs
                self?.fetchRates(for: pairs, at: Constants.defaultInterval)
            case .failure(let error):
                self?.stopFetchingExchangeRates()
                self?.router?.showAlert(message: error.localizedDescription) {
                    self?.startFetchingExchangeRates()
                }
            }
        }
    }
    
    public func deletePairAtIndex(_ index: Int) {
        guard pairsModel.indices.contains(index) else { return }
        pairUseCase.delete(pairsModel[index]) { [weak self] result in
            switch result {
            case .success: break
            case .failure(let error):
                self?.stopFetchingExchangeRates()
                self?.router?.showAlert(message: error.localizedDescription) {
                    self?.startFetchingExchangeRates()
                }
            }
        }
    }
    
    private func fetchRates(for pairs: [Pair], at interval: TimeInterval) {
        exchangePairProvider.getExchangePairs(for: pairs, at: interval) { [weak self] result in
            switch result {
            case .success(let exchangePairs):
                exchangePairs.isEmpty ? self?.setEmpty() : self?.setCongiguredPairs()
                self?.configure(with: exchangePairs.map(ExchangePairViewFormatter.make))
            case .failure(let error):
                self?.stopFetchingExchangeRates()
                self?.router?.showAlert(message: error.localizedDescription) {
                    self?.startFetchingExchangeRates()
                }
            }
        }
    }
    
    private func configure(with viewPairs: [ExchangePairView]) {
        if viewPairs.count == (previouslyRetrievedPairs + 1) {
            pairs.value = Array(viewPairs.dropFirst())
            newPair.value = viewPairs.first
        } else {
            pairs.value = viewPairs
        }
        previouslyRetrievedPairs = viewPairs.count
    }
    
    private func setEmpty() {
        stopFetchingExchangeRates()
        isEmptyScreen.value = true
    }
    
    private func setCongiguredPairs() {
        guard isEmptyScreen.value else { return }
        isEmptyScreen.value = false
    }

    public func stopFetchingExchangeRates() {
        exchangePairProvider.stopRetreavingPairs()
    }
    
    public func addPairDidTapp() {
        router?.showAddCurrencyScreen()
    }
    
    private enum Constants {
        static let defaultInterval: TimeInterval = 1.0
    }
    
    private enum Localizables {
        static let title = "Rates and Currencies"
    }
}
