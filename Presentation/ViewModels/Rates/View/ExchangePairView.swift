//
//  ExchangePairView.swift
//  Presentation
//
//  Created by Aaron Huánuco on 24/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

public struct ExchangePairView {
    public let origin: OriginCurrencyView
    public let destination: DestinationCurrencyView
}

public struct OriginCurrencyView {
    public let title: String
    public let subtitle: String
}

public struct DestinationCurrencyView {
    public let title: String
    public let subtitle: String
}
