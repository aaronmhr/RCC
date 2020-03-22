//
//  CurrenciesViewModel.swift
//  Presentation
//
//  Created by Aaron Huánuco on 22/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

public protocol CurrenciesViewModel {
    var currencies: Box<[CurrencyView]> { get }
    func didSelectCurrencyAtIndex(_ index: Int)
}
