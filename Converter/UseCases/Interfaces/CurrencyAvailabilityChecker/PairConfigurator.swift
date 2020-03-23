//
//  PairConfigurator.swift
//  Converter
//
//  Created by Aaron Huánuco on 22/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

public protocol PairConfigurator {
    typealias PairingResult = Swift.Result<[(currency: Currency, isAvailable: Bool)], Error>
    
    func pairingAvailable(within currencies: [Currency], completion: @escaping (PairingResult) -> Void)
    func savePair(with currency: Currency, completion: @escaping (Result<Void, Error>) -> Void)
}
