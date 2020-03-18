//
//  RatesRouter.swift
//  RCC
//
//  Created by Aaron Huánuco on 17/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import UIKit


final class RatesRouter: StoryboardInstantiator {
    weak var view: RatesViewController!

    init(withView view: RatesViewController) {
        self.view = view
    }

    static func assembleModule() -> UIViewController {
        let viewController = defaultViewController(for: RatesViewController.self)
        viewController.viewModel = ExchangeViewModelAssembler.assemble()

        return viewController
    }
}

//extension RatesRouter: RatesRouterProtocol {
//
//}
