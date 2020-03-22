//
//  CurrenciesRouter.swift
//  RCC
//
//  Created by Aaron Huánuco on 21/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import UIKit
import Converter
import Presentation

final class FirstCurrenciesRouter: StoryboardInstantiator {
    weak var view: CurrenciesViewController!

    init(withView view: CurrenciesViewController) {
        self.view = view
    }

    static func assembleModule() -> UIViewController {
        let viewController = defaultViewController(for: CurrenciesViewController.self)
        let router = FirstCurrenciesRouter(withView: viewController)
        let viewModel = FirstCurrencyViewModelAssembler.assemble()
        viewModel.router = router
        viewController.viewModel = viewModel
        
        return viewController
    }
}

extension FirstCurrenciesRouter: FirstCurrencyRouterProtocol {
    func showSecondCurrencySelector(for currency: Currency) {
        let viewController = SecondCurrenciesRouter.assembleModule(for: currency)
        view.navigationController?.pushViewController(viewController, animated: true)
    }
}
