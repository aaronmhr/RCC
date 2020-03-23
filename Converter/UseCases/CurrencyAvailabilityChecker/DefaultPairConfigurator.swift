//
//  DefaultPairConfigurator.swift
//  Converter
//
//  Created by Aaron Huánuco on 22/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

public final class DefaultPairConfigurator: PairConfigurator {
    private let selectedCurrency: Currency
    private var pairUseCase: PairInteractorProtocol
    public typealias PairingResult = PairConfigurator.PairingResult
    
    public init(selectedCurrency: Currency, pairUseCase: PairInteractorProtocol) {
        self.selectedCurrency = selectedCurrency
        self.pairUseCase = pairUseCase
    }
    
    public func pairingAvailable(within currencies: [Currency], completion: @escaping (PairingResult) -> Void) {
        let selectedCurrency = self.selectedCurrency
        pairs { result in
            switch result {
            case .success(let configuredPairs):
                let unavailableCurrencies = configuredPairs.filter { $0.first == selectedCurrency }.map { $0.second } + [selectedCurrency]
                let currenciesFormatted = currencies.map { (currency: $0, isAvailable: !unavailableCurrencies.contains($0)) }
                completion(.success(currenciesFormatted))
            case .failure: break
            }
        }
    }
    
    public func savePair(with currency: Currency, completion: @escaping (Result<Void, Error>) -> Void) {
         let pair = Pair(with: selectedCurrency, and: currency)
        pairUseCase.save(pair, completion: completion)
     }
    
    private func pairs(completion: @escaping (Result<[Pair], Error>) -> Void) {
        return pairUseCase.getConfiguredPairs(completion: completion)
    }
}
