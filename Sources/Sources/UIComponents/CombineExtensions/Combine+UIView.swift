//
//  Combine+UIView.swift
//
//
//  Created by Павел Гришутенко on 21.09.2023.
//

import Combine
import UIKit

public extension UIView {
    enum GesturesTypes {
        case tap
        case doubleTap
        case longTap
        case swipeLeft
        case swipeRight
        case swipeTop
        case swipeBottom
    }
  
  
    class InteractionSubscription<S: Subscriber>: Subscription where S.Input == UIGestureRecognizer {
        private var subscriber: S?
        private let view: UIView
        private let gesture: GesturesTypes
        
        init(
            subscriber: S,
            view: UIView,
            gesture: GesturesTypes
        ) {
            self.subscriber = subscriber
            self.view = view
            self.gesture = gesture

            var gestureRecognizer: UIGestureRecognizer?

            switch gesture {
            case .tap:
                gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleEvent))
            case .doubleTap:
                gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleEvent))
                (gestureRecognizer as? UITapGestureRecognizer)?.numberOfTapsRequired = 2
            default:
              break
            }
            guard let gestureRecognizer else { return }
            self.view.addGestureRecognizer(gestureRecognizer)
        }
    
        public func request(_ demand: Subscribers.Demand) {}
    
        public func cancel() {
            subscriber = nil
        }
    
        @objc func handleEvent(_ gesture: UIGestureRecognizer) {
            _ = self.subscriber?.receive(gesture)
        }
  }
  
    struct InteractionPublisher: Publisher {
        public typealias Output = UIGestureRecognizer
        public typealias Failure = Never

        private let gesture: GesturesTypes
        private let view: UIView
    
        init(view: UIView, gesture: GesturesTypes) {
            self.gesture = gesture
            self.view = view
        }
    
        public func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, UIGestureRecognizer == S.Input {

            let subscription = InteractionSubscription(
                subscriber: subscriber,
                view: view,
                gesture: gesture
            )
            subscriber.receive(subscription: subscription)
        }
    }
  
    func gesture(_ event: GesturesTypes) -> InteractionPublisher {
        return InteractionPublisher(view: self, gesture: event)
    }
}
