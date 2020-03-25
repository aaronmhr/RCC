//
//  SecondCurrenciesRouter.swift
//  RCC
//
//  Created by Aaron Huánuco on 22/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import UIKit
import Converter
import Presentation

final class SecondCurrenciesRouter: StoryboardInstantiator {
    weak var view: CurrenciesViewController!

    init(withView view: CurrenciesViewController) {
        self.view = view
    }

    static func assembleModule(for currency: Currency) -> UIViewController {
        let viewController = defaultViewController(for: CurrenciesViewController.self)
        let router = SecondCurrenciesRouter(withView: viewController)
        let viewModel = SecondCurrencyViewModelAssembler.assemble(for: currency)
        viewModel.router = router
        viewController.viewModel = viewModel
        
        return viewController
    }
}

extension SecondCurrenciesRouter: SecondCurrencyRouterProtocol {
    func dismiss() {
        DispatchQueue.main.async {
            self.view.navigationController?.dismiss(animated: true, completion: nil)
        }
    }
}
