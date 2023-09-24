//
//  Combine+UIControll.swift
//  
//
//  Created by Павел Гришутенко on 21.09.2023.
//

import Combine
import UIKit

public extension UIControl {
    class InteractionSubscription<S: Subscriber>: Subscription where S.Input == UIControl {
        private var subscriber: S?
        private let control: UIControl
        private let event: UIControl.Event
    
        init(
            subscriber: S,
            control: UIControl,
            event: UIControl.Event
        ) {
            self.subscriber = subscriber
              self.control = control
              self.event = event
              
              self.control.addTarget(self, action: #selector(handleEvent), for: event)
        }
        
        public func request(_ demand: Subscribers.Demand) {}
        
        public func cancel() {
            subscriber = nil
        }
        
        @objc func handleEvent(_ sender: UIControl) {
            _ = self.subscriber?.receive(sender)
        }
    }
  
    struct InteractionPublisher: Publisher {
        public typealias Output = UIControl
        public typealias Failure = Never

        private let control: UIControl
        private let event: UIControl.Event
    
        init(control: UIControl, event: UIControl.Event) {
            self.control = control
            self.event = event
        }
    
        public func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, UIControl == S.Input {
            let subscription = InteractionSubscription(
                subscriber: subscriber,
                control: control,
                event: event
            )
            subscriber.receive(subscription: subscription)
        }
    }
  
    func gesture(_ event: UIControl.Event) -> UIControl.InteractionPublisher {
        return InteractionPublisher(control: self, event: event)
    }
}
