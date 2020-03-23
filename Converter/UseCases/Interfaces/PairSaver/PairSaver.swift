//
//  PairSaver.swift
//  Converter
//
//  Created by Aaron Huánuco on 17/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

public protocol PairSaver {
    func save(_ pair: Pair, completion: @escaping (Result<Void, Error>) -> Void)
}
