//
//  DefaultFavoritesRepository.swift
//  Data
//
//  Created by Aaron Huánuco on 21/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import Converter

public final class DefaultFavoritesRepository: FavoriteCurrencyRepository {
    public init() { }
    
    public var favoriteCurrencyCodes: [String] {
        let response: [String]? = try? String.readJSONFrom(from: "favorites", bundle: bundle)
        return response ?? []
    }
    
    private var bundle: Bundle  {
        return Bundle(for: type(of: self))
    }
}
