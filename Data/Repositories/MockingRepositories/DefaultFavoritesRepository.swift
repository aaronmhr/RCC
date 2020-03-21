//
//  DefaultFavoritesRepository.swift
//  Data
//
//  Created by Aaron Huánuco on 21/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import Converter

public final class DefaultFavoritesRepository: FavoriteCurrencyRepository {
    public var favoriteCurrencyCodes: [String] {
        let response: CurrencyCodeResponse? = try? CurrencyCodeResponse.readJSONFrom(from: "favorites", bundle: bundle)
        return response?.codes ?? []
    }
    
    private var bundle: Bundle  {
        return Bundle(for: type(of: self))
    }
}
