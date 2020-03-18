//
//  RatesViewModelAssembler.swift
//  RCC
//
//  Created by Aaron Huánuco on 18/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import Converter
import Data
import Presentation

final class ExchangeViewModelAssembler {
    
    static func assemble() -> RatesViewModel {
        let pairUseCase = assemblePairUseCase()
        let exchangeUseCase = assembleExchangeUseCase()
        
        return RatesViewModel(pairUseCase: pairUseCase, exchangePairProvider: exchangeUseCase)
    }
    
    private static func assemblePairUseCase() -> PairInteractorProtocol {
        let repository = MockingPairRepository()
        return  PairUseCase(repository: repository)
    }
    
    private static func assembleExchangeUseCase() -> ExchangePairProvider {
        let httpClient = URLSessionHTTPClient()
        let dataSource = RemoteExchangeRatesDataSource(remoteClient: httpClient)
        let exchangeRepository = DefaultExchangeRepository(dataSource: dataSource)
        
        let timer = DefaultTimer()
        
        return ExchangeUseCase(repository: exchangeRepository, timer: timer)
    }
}
