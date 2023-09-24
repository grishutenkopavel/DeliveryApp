//
//  ProductsListView.swift
//  
//
//  Created by Павел Гришутенко on 23.09.2023.
//

import Combine
import UIKit
import UIComponents

final class ProductsListView: UIView {
    
    let headerCollectionShown = PassthroughSubject<Void, Never>()
    lazy var supplementaryProvider: (_ collectionView: UICollectionView, _ elementKind: String, _ indexPath: IndexPath) -> UICollectionReusableView? = { [weak self] (collectionView, elementKind, indexPath) -> UICollectionReusableView? in
        if elementKind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: elementKind,
                withReuseIdentifier: String(describing: MenuCollectionView.self),
                for: indexPath
            )
            self?.headerCollection = (headerView as? MenuCollectionView)?.headerCollection
            self?.headerTitle = (headerView as? MenuCollectionView)?.headerTitle
            self?.headerCollectionShown.send()
            return headerView
        }
        return UICollectionReusableView()
    }
    
    private weak var headerCollection: UICollectionView?
    weak var headerTitle: UILabel?
    
    private let collectionView: UICollectionView = {
        let layout = ProductsListLayout().createSubMenuListLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .backgroundColor
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(SubMenuCollectionViewCell.self)
        collectionView.register(
            MenuCollectionView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: String(describing: MenuCollectionView.self)
        )
        return collectionView
    }()
    
    private let activiryThrobber: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.startAnimating()
        view.hidesWhenStopped = true
        view.style = .large
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareView()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showLoading(_ isLoading: Bool) {
        activiryThrobber.isHidden = !isLoading
        isLoading ? activiryThrobber.startAnimating() : activiryThrobber.stopAnimating()
        
    }
    
    private func prepareView() {
        addSubviews(collectionView, activiryThrobber)
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            activiryThrobber.centerYAnchor.constraint(equalTo: centerYAnchor),
            activiryThrobber.centerXAnchor.constraint(equalTo: centerXAnchor),
            activiryThrobber.widthAnchor.constraint(equalToConstant: 60),
            activiryThrobber.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}

extension ProductsListView {
    var subMenuList: UICollectionView {
        collectionView
    }
    
    var menuList: UICollectionView {
        return headerCollection ?? UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    }
}
