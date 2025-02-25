//
//  ExchangeUseCase.swift
//  Converter
//
//  Created by Aaron Huánuco on 17/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

public final class ExchangeUseCase: ExchangePairProvider {
    private let repository: ExchangeRepository
    private let timer: TimerProtocol
    
    public init(repository: ExchangeRepository, timer: TimerProtocol) {
        self.repository = repository
        self.timer = timer
    }
    
    public func getExchangePairs(for pairs: [Pair], at interval: TimeInterval, completion: @escaping (ExchangePairProvider.Result) -> Void) {
        DispatchQueue.main.async { [weak self] in
            self?.timer.schedule(timeInterval: interval, repeats: true) {
                self?.repository.getExchangePairs(for: pairs, completion: { result in
                    let newResult = result.mapError { _ -> ExchangeProviderError in
                        return .remote
                    }
                    completion(newResult)
                })
            }
            self?.timer.fire()
        }
    }
    
    public func stopRetreavingPairs() {
        timer.invalidate()
    }
}
