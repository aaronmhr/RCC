//
//  RatesPresenter.swift
//  RCC
//
//  Created by Aaron Huánuco on 17/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

final class RatesPresenter {
    let router: RatesRouterProtocol
    let interactor: RatesInteractorProtocol
    weak var view: RatesViewProtocol!

    init(withView view: RatesViewProtocol, interactor: RatesInteractorProtocol, router: RatesRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension RatesPresenter: RatesPresenterProtocol {

}
