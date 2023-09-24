//
//  MenuDataSourceProvider.swift
//  
//
//  Created by Павел Гришутенко on 24.09.2022.
//

import Combine
import Foundation
import UIComponents
import UIKit


protocol CollectionDataSourceProvider {
    typealias SupplimentaryProvider = (_ collectionView: UICollectionView, _ elementKind: String, _ indexPath: IndexPath) -> UICollectionReusableView?
    associatedtype SectionId: Hashable
    associatedtype ItemId: Hashable
    associatedtype DiffableDataSource: UICollectionViewDiffableDataSource<SectionId, ItemId>

    func setDataSource(for collectionView: UICollectionView)
    func update(items: [ItemId], in collectionView: UICollectionView)
    func setSupplimentaryProvider(_ supplimentaryProvider: SupplimentaryProvider?, for collectionView: UICollectionView)
}

class MenuDataSourceProvider: CollectionDataSourceProvider {
    typealias SectionId = Int
    typealias ItemId = MenuCellModel
    typealias DiffableDataSource = UICollectionViewDiffableDataSource<Int, MenuCellModel>
  
    private var dataSource: DiffableDataSource?
  
    func setDataSource(for collectionView: UICollectionView) {
        dataSource = DiffableDataSource(collectionView: collectionView)
        { tableView, indexPath, model in
      
            let cell = collectionView.dequeueReusableCell(MenuCollectionViewCell.self, for: indexPath)
            cell?.configure(model)
            return cell ?? UICollectionViewCell()
        }
      
        collectionView.dataSource = dataSource
    }

    func update(items: [MenuCellModel], in collectionView: UICollectionView) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, MenuCellModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(items, toSection: 0)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
    
    func setSupplimentaryProvider(_ supplimentaryProvider: SupplimentaryProvider?, for collectionView: UICollectionView) {
        dataSource?.supplementaryViewProvider = supplimentaryProvider
    }
}
