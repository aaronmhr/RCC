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
    
    public init(pairUseCase: PairInteractorProtocol, exchangePairProvider: ExchangePairProvider) {
        self.pairUseCase = pairUseCase
        self.exchangePairProvider = exchangePairProvider
    }
    
    private(set) var pairs: Box<[ExchangePair]> = Box([])
    
    func retrieve() {
        let pairs = pairUseCase.getConfiguredPairs()
        exchangePairProvider.getExchangePairs(for: pairs, at: 1) { result in
            self.pairs.value = result.value!
        }
    }
}

class TestViewController {
    var viewModel: RatesViewModel!
    
    func viewDidLoad() {
//        viewModel.pairs.bind { pair in
//            <#code#>
//        }
        viewModel.retrieve()
    }
}

public final class Box<T> {
    public typealias Listener = (T) -> Void
    private var listener: Listener?
    
    public var value: T {
        didSet { execute(with: value) }
    }
    
    public init(_ value: T) {
        self.value = value
    }
    
    public func bind(listener: Listener?) {
        self.listener = listener
        execute(with: value)
    }
    
    private func execute(with value: T) {
        Thread.isMainThread ? listener?(value) : DispatchQueue.main.async { self.listener?(value) }
    }
}
