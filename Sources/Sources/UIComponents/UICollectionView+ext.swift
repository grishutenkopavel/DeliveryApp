//
//  UICollectionView+ext.swift
//  
//
//  Created by Павел Гришутенко on 21.09.2023.
//

import UIKit

public extension UICollectionView {
    func register<T: AnyObject>(_ cellClass: T.Type) {
        register(cellClass, forCellWithReuseIdentifier: String(describing: cellClass.self))
    }
  
    func dequeueReusableCell<T: AnyObject>(_ cellClass: T.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withReuseIdentifier: String(describing: cellClass.self), for: indexPath) as? T
    }
}
