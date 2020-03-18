//
//  RatesRouter.swift
//  RCC
//
//  Created by Aaron Huánuco on 17/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import UIKit
import Converter
import Data
import Presentation

final class RatesRouter: StoryboardInstantiator {
    weak var view: RatesViewController!

    init(withView view: RatesViewController) {
        self.view = view
    }

    static func assembleModule() -> UIViewController {
        let viewController = defaultViewController(for: RatesViewController.self)
        let router = RatesRouter(withView: viewController)

        let interactor = RatesInteractor()

        viewController.viewModel = ExchangeViewModelAssembler.assemble()

        return viewController
    }
}

extension RatesRouter: RatesRouterProtocol {

}

final class ExchangeViewModelAssembler {
    
    static func assemble() -> RatesViewModel {
        let pairUseCase = assemblePairUseCase()
        let exchangeUseCase = assembleExchangeUseCase()
        
        return RatesViewModel(pairUseCase: pairUseCase, exchangePairProvider: exchangeUseCase)
    }
    
    private static func assemblePairUseCase() -> PairInteractorProtocol {
        let repository = MockingPairRepository()
        return  PairInteractor(repository: repository)
    }
    
    private static func assembleExchangeUseCase() -> ExchangePairProvider {
        let httpClient = URLSessionHTTPClient()
        let dataSource = RemoteExchangeRatesDataSource(remoteClient: httpClient)
        let exchangeRepository = DefaultExchangeRepository(dataSource: dataSource)
        
        let timer = DefaultTimer()
        
        return ExchangeUseCase(repository: exchangeRepository, timer: timer)
    }
}
