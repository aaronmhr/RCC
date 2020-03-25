//
//  RatesRouterProtocol.swift
//  Presentation
//
//  Created by Aaron Huánuco on 22/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

public protocol RatesRouterProtocol {
    func showAddCurrencyScreen()
    func showAlert(message: String, action: @escaping () -> Void)
}
