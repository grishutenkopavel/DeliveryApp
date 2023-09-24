//
//  ViewModel.swift
//  
//
//  Created by Павел Гришутенко on 21.09.2023.
//

import Combine
import Foundation

public protocol ViewModel: AnyObject {
    associatedtype State
    associatedtype ErrorType: Error
    associatedtype Actions
    associatedtype Mutations
    var state: CurrentValueSubject<State, ErrorType> { get set }
    var cancellable: Set<AnyCancellable> { get set }
    var currentState: State { get set }
  
    func action(_ action: Actions)
    func reduce(_ action: Actions) -> AnyPublisher<Mutations, ErrorType>
    func mutate(_ state: State, _ mutation: Mutations) -> State
}

public extension ViewModel {
    func reduce(_ action: Actions) -> AnyPublisher<Mutations, ErrorType> { return Empty(completeImmediately: false).eraseToAnyPublisher() }
    func mutate(_ state: State, _ mutation: Mutations) -> State { return state }
    func action(_ action: Actions) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            var subscription: AnyCancellable?
            subscription = self.reduce(action)
                .receive(on: DispatchQueue.main)
                .sink(
                    receiveCompletion: { _ in },
                    receiveValue: { mutation in
                        self.state.value = self.mutate(self.currentState, mutation)
                        guard let subscription else { return }
                        self.cancellable.remove(subscription)
                    }
                )
            subscription?.store(in: &self.cancellable)
        }
    }
  
    var currentState: State {
        get {
            return state.value
        }
        set {
            currentState = state.value
        }
    }
}
