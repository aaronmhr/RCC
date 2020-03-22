//
//  RatesRouter.swift
//  RCC
//
//  Created by Aaron Huánuco on 17/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import UIKit
import Presentation

final class RatesRouter: StoryboardInstantiator {
    weak var view: RatesViewController!

    init(with view: RatesViewController) {
        self.view = view
    }

    static func assembleModule() -> UIViewController {
        let viewController = defaultViewController(for: RatesViewController.self)
        let router = RatesRouter(with: viewController)
        let viewModel = ExchangeViewModelAssembler.assemble()
        viewModel.router = router
        viewController.viewModel = viewModel

        return viewController
    }
}

extension RatesRouter: RatesRouterProtocol {
    func showAddCurrencyScreen() {
        let viewController = FirstCurrenciesRouter.assembleModule()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        view.present(navigationController, animated: true, completion: nil)
    }
}
