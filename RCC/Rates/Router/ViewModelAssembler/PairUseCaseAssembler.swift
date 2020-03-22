//
//  PairUseCaseAssembler.swift
//  RCC
//
//  Created by Aaron Huánuco on 22/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import Converter
import Data

let repository = MockingPairRepository()

final class PairUseCaseAssembler {
    static func assemble() -> PairInteractorProtocol {
        return  PairUseCase(repository: repository)
    }
}
