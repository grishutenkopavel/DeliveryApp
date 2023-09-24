//
//  SubMenuDataSourceProvider.swift
//
//
//  Created by Павел Гришутенко on 24.09.2022.
//

import Combine
import Foundation
import UIComponents
import UIKit


class SubMenuDataSourceProvider: CollectionDataSourceProvider {
    typealias SectionId = Int
    typealias ItemId = SubMenuCellModel
    typealias DiffableDataSource = UICollectionViewDiffableDataSource<Int, SubMenuCellModel>
  
    let headerCollectionShown = PassthroughSubject<Void, Never>()
    
    weak var headerCollection: UICollectionView?
    
    private var dataSource: DiffableDataSource?
  
    func setDataSource(for collectionView: UICollectionView) {
        dataSource = DiffableDataSource(collectionView: collectionView)
        { collectionView, indexPath, model in
      
            let cell = collectionView.dequeueReusableCell(SubMenuCollectionViewCell.self, for: indexPath)
            cell?.configure(model)
            return cell ?? UICollectionViewCell()
        }
        
        collectionView.dataSource = dataSource
    }
    

    func update(items: [SubMenuCellModel], in collectionView: UICollectionView) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, SubMenuCellModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(items, toSection: 0)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
    
    func setSupplimentaryProvider(_ supplimentaryProvider: SupplimentaryProvider?, for collectionView: UICollectionView) {
        dataSource?.supplementaryViewProvider = supplimentaryProvider
    }
}
