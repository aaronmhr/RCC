//
//  CurrenciesRouter.swift
//  RCC
//
//  Created by Aaron Huánuco on 21/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import UIKit

final class CurrenciesRouter: StoryboardInstantiator {
    weak var view: CurrenciesViewController!

    init(withView view: CurrenciesViewController) {
        self.view = view
    }

    static func assembleModule() -> UIViewController {
        let viewController = defaultViewController(for: CurrenciesViewController.self)
        let router = CurrenciesRouter(withView: viewController)

        return viewController
    }
}

extension CurrenciesRouter {

}
