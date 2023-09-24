//
//  Combine+UICollectionView.swift
//  
//
//  Created by Павел Гришутенко on 24.09.2023.
//


import Combine
import UIKit

public enum CollectionViewEventType {
    case cellWillAppear
    case cellDidSelected
}

public extension UICollectionView {
    class InteractionSubscription<S: Subscriber, SectionModel: Hashable, ItemModel: Hashable>: NSObject, UICollectionViewDelegate, Subscription where S.Input == (ItemModel, CollectionViewEventType) {
        private var subscriber: S?
        private let collectionView: UICollectionView
        
        init(
            subscriber: S,
            collectionView: UICollectionView
        ) {
            self.subscriber = subscriber
            self.collectionView = collectionView
            super.init()
            collectionView.delegate = self
        }
        
        public func request(_ demand: Subscribers.Demand) {}
        
        public func cancel() {
            subscriber = nil
        }
        
        public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            sendItem(collectionView, at: indexPath, event: .cellDidSelected)
        }
        
        public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            sendItem(collectionView, at: indexPath, event: .cellWillAppear)
        }
        
        func sendItem(_ collectionView: UICollectionView, at indexPath: IndexPath, event: CollectionViewEventType) {
            let dataSource = collectionView.dataSource as? UICollectionViewDiffableDataSource<SectionModel, ItemModel>
            guard let item = dataSource?.itemIdentifier(for: indexPath) else { return }
            _ = self.subscriber?.receive((item, event))
        }
    }
    
    struct InteractionPublisher<SectionModel: Hashable, ItemModel: Hashable>: Publisher {

         public typealias Output = (ItemModel, CollectionViewEventType)
         public typealias Failure = Never

         private let collectionView: UICollectionView
        
        init(collectionView: UICollectionView) {
            self.collectionView = collectionView
        }
       
         public func receive<S>(subscriber: S) where S: Subscriber, Never == S.Failure, (ItemModel, CollectionViewEventType) == S.Input {
             let subscription = InteractionSubscription<S, SectionModel, ItemModel>(
                subscriber: subscriber,
                collectionView: collectionView
             )
             subscriber.receive(subscription: subscription)
         }
     }
     
    func getItemAtModel<SectionModel: Hashable, ItemModel: Hashable>(
        sectionModel: SectionModel.Type,
        itemModel: ItemModel.Type
    ) -> UICollectionView.InteractionPublisher<SectionModel, ItemModel> {
        return InteractionPublisher(collectionView: self)
    }
}
