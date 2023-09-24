//
//  MenuCollectionView.swift
//  
//
//  Created by Павел Гришутенко on 23.09.2023.
//

import UIKit
import UIComponents


final class MenuCollectionView: UICollectionReusableView {
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 117, height: 125)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .backgroundColor
        collectionView.register(MenuCollectionViewCell.self)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let titleOfCollection: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareView()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareView() {
        addSubviews(collectionView, titleOfCollection)
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(greaterThanOrEqualTo: titleOfCollection.topAnchor, constant: -10),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            titleOfCollection.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            titleOfCollection.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleOfCollection.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
}

extension MenuCollectionView {
    var headerCollection: UICollectionView {
        collectionView
    }
    
    var headerTitle: UILabel {
        titleOfCollection
    }
}
