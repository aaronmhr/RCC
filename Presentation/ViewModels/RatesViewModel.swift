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
    
    
}
